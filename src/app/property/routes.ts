import express from "express";
import { authenticateToken } from "../../helper/authenticationToken";
import {
  createProperty,
  deletePropertyById,
  getAllProperty,
  getPropertyById,
  updatePropertyById,
  getAllPropertyExpired,
  searchProperty,
  detectPropertyObject,
} from "./controller";
import { handleUploadMiddleware } from "../../config/s3UploadFileConfig";
const router = express.Router();

router.post(
  "/",
  authenticateToken,
  handleUploadMiddleware.array("image", 1),
  createProperty
);
router.get("/all", authenticateToken, getAllProperty);
router.get("/:id", authenticateToken, getPropertyById);
router.delete("/:id", authenticateToken, deletePropertyById);
router.put("/:id", authenticateToken, updatePropertyById);
router.get("/all/expired", authenticateToken, getAllPropertyExpired);
router.get("/search/:name", authenticateToken, searchProperty);
router.post("/object-detection", detectPropertyObject);
export default router;
