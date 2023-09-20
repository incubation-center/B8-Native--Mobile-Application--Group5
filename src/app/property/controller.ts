import { Request, Response } from "express";
import { JwtPayload } from "jsonwebtoken";
import PropertyModel from "../property/models";
import CategoryModel from "../category/models";
const { Op } = require("sequelize");

// * Tensorflow Stuff
import * as tf from "@tensorflow/tfjs-node";
import * as coco_ssd from "@tensorflow-models/coco-ssd";

// * Server Stuff
const busboy = require("busboy");

// * Init Model
let model: any = undefined;
(async () => {
  model = await coco_ssd.load({
    base: "mobilenet_v1",
  });
})();

interface AuthenticatedRequest extends Request {
  user?: JwtPayload;
}

export const createProperty = async (
  req: AuthenticatedRequest,
  res: Response
) => {
  try {
    const { name, price, expired_at, alert_at, categoryId } = req.body;
    // define type of req.files
    type MulterFile = Express.Multer.File & { location?: string };
    const files = req.files as MulterFile[];
    const image_url = files[0]?.location;

    const property = await PropertyModel.create({
      name,
      price,
      expired_at,
      alert_at,
      image: image_url,
      categoryId,
      userId: req.user?.id,
    });
    res.status(202).json(property);
  } catch (error) {
    console.error("Error", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const getPropertyById = async (
  req: AuthenticatedRequest,
  res: Response
) => {
  try {
    const { id } = req.params;
    const property = await PropertyModel.findOne({ where: { id } });
    if (!property) return res.status(404).json({ error: "Property not found" });
    res.status(200).json(property);
  } catch (error) {
    console.error("Error", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const updatePropertyById = async (
  req: AuthenticatedRequest,
  res: Response
) => {
  try {
    const { id } = req.params;
    const { name, price, expired_at, alert_at, categoryId } = req.body;

    const property = await PropertyModel.findOne({
      where: { id, userId: req.user?.id },
    });
    if (!property) return res.status(404).json({ error: "Property not found" });
    if (name) property.name = name;
    if (price) property.price = price;
    if (expired_at) property.expired_at = expired_at;
    if (alert_at) property.alert_at = alert_at;
    if (categoryId) property.categoryId = categoryId;
    await property.save();
    res.status(200).json(property);
  } catch (error) {
    console.error("Error", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const deletePropertyById = async (
  req: AuthenticatedRequest,
  res: Response
) => {
  try {
    const { id } = req.params;
    const property = await PropertyModel.findOne({
      where: { id, userId: req.user?.id },
    });
    if (!property) return res.status(404).json({ error: "Property not found" });
    property.isDeleted = true;
    await property.save();
    res.status(200).json({ message: "Property deleted" });
  } catch (error) {
    console.error("Error", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const getAllProperty = async (
  req: AuthenticatedRequest,
  res: Response
) => {
  try {
    const category = await CategoryModel.findAll({
      where: { userId: req.user?.id },
    });
    for (const i in category) {
      const property = await PropertyModel.findAll({
        where: {
          categoryId: category[i].id,
          isDeleted: false,
          [Op.or]: [
            { expired_at: null },
            { expired_at: { [Op.gte]: new Date() } },
          ],
        },
      });
      category[i].setDataValue("properties", property);
    }
    res.status(200).json(category);
  } catch (error) {
    console.error("Error", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const getAllPropertyExpired = async (
  req: AuthenticatedRequest,
  res: Response
) => {
  try {
    const currentDate = new Date();
    const property = await PropertyModel.findAll({
      where: {
        userId: req.user?.id,
        isDeleted: false,
        expired_at: {
          [Op.and]: [{ [Op.not]: null }, { [Op.lte]: currentDate }],
        },
      },
    });
    res.status(200).json(property);
  } catch (error) {
    console.error("Error", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const searchProperty = async (
  req: AuthenticatedRequest,
  res: Response
) => {
  try {
    console.log(req);
    const { name } = req.params;
    const property = await PropertyModel.findAll({
      where: { name: { [Op.like]: `%${name}%` }, userId: req.user?.id },
      limit: 10,
    });
    res.status(200).json(property);
  } catch (error) {
    console.error("Error", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const detectPropertyObject = async (req: Request, res: Response) => {
  if (!model) {
    res.status(500).send({ error: "Model not loaded yet" });
    return;
  }

  // * Create Busboy instance to extract the file from the request
  const bb = busboy({ headers: req.headers });

  // * Listen for event when Busboy finds a file to stream
  bb.on(
    "file",
    (
      fieldname: string,
      file: NodeJS.ReadableStream,
      filename: string,
      encoding: string,
      mimetype: string
    ) => {
      // * Create buffer to store the file chunks
      const buffer: Buffer[] = [];

      // * Listen for event when Busboy is streaming the file
      file.on("data", data => {
        buffer.push(data);
      });

      // * Listen for event when Busboy finishes streaming the file
      file.on("end", async () => {
        const image = tf.node.decodeImage(Buffer.concat(buffer));
        const predictions = await model.detect(image, 3, 0.25);

        // * Example of predictions
        // [
        //   {
        //       "bbox": [
        //           465.17964220046997,
        //           1060.762596130371,
        //           2098.3927702903748,
        //           2175.723976135254
        //       ],
        //       "class": "cup",
        //       "score": 0.9737628698348999
        //   }
        // ]

        // * Select the first prediction with the highest score and return its class name
        const highestScorePrediction = predictions[0];
        res.json({ object: highestScorePrediction.class });
      });
    }
  );

  req.pipe(bb);
};
