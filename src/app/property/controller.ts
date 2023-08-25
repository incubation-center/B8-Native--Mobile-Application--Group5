import { Request, Response } from 'express';
import { JwtPayload } from 'jsonwebtoken';
import UserModel from '../user/models';
import PropertyModel from '../property/models';
import CategoryModel from '../category/models';
const { Op } = require('sequelize');

interface AuthenticatedRequest extends Request {
    user?: JwtPayload;
  }

export const createProperty = async (req: AuthenticatedRequest, res: Response) => {
    try {
        const { name, price, expired_at, alert_at, categoryId } = req.body;
        const property = await PropertyModel.create({ name, price, expired_at, alert_at, categoryId, userId: req.user?.id });
        res.status(202).json(property);
    } catch (error) {
        console.error('Error', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

export const getPropertyById = async (req: AuthenticatedRequest, res: Response) => {
    try{
        const { id } = req.params;
        const property = await PropertyModel.findOne({where: {id}});
        if(!property) return res.status(404).json({error: 'Property not found'});
        res.status(200).json(property);
    }catch (error) {
        console.error('Error', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

export const updatePropertyById = async (req: AuthenticatedRequest, res: Response) => {
    try{
        const { id } = req.params;
        const { name, price, expired_at, alert_at, categoryId } = req.body;

        const property = await PropertyModel.findOne({where: {id, userId: req.user?.id}});
        if(!property) return res.status(404).json({error: 'Property not found'});
        if(name) property.name = name;
        if(price) property.price = price;
        if(expired_at) property.expired_at = expired_at;
        if(alert_at) property.alert_at = alert_at;
        if(categoryId) property.categoryId = categoryId;
        await property.save();
        res.status(200).json(property);
    }catch (error) {
        console.error('Error', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

export const deletePropertyById = async (req: AuthenticatedRequest, res: Response) => {
    try{
        const { id } = req.params;
        const property = await PropertyModel.findOne({where: {id, userId: req.user?.id}});
        if(!property) return res.status(404).json({error: 'Property not found'});
        await property.destroy();
        res.status(200).json({message: 'Property deleted'});
    } catch (error) {
        console.error('Error', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

export const getAllProperty = async (req: AuthenticatedRequest, res: Response) => {
   try{
        const category = await CategoryModel.findAll({where: { userId: req.user?.id }});
        for (const i in category) {
        const property = await PropertyModel.findAll({where: { categoryId: category[i].id }});
        category[i].setDataValue('properties', property);
        }
        res.status(200).json(category);
    } catch (error) {
        console.error('Error', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

export const getAllPropertyExpired = async (req: AuthenticatedRequest, res: Response) => {
    try{
        const currentDate = new Date();
        const property = await PropertyModel.findAll({where: { userId: req.user?.id , expired_at: {[Op.lte]: currentDate} }});
        res.status(200).json(property);
    } catch (error) {
        console.error('Error', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}