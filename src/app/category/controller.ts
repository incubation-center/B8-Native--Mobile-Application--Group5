import { Request, Response } from 'express';
import CategoryModel from './models';
import { JwtPayload } from 'jsonwebtoken';

interface AuthenticatedRequest extends Request {
    user?: JwtPayload;
  }
export const createCategory = async (req: AuthenticatedRequest, res: Response) => {
    try {
        const { name } = req.body;
        const category = await CategoryModel.create({ name, userId: req.user?.id });
        res.status(202).json(category);
    } catch (error) {
      console.error('Error creating user:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  };

export const getAllCategory = async (req: AuthenticatedRequest, res: Response) => {
  try{
    const category = await CategoryModel.findAll({where: { userId: req.user?.id }});
    res.status(200).json(category);
  }catch (error) {
    console.error('Error creating user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}

export const getCategoryById = async (req: AuthenticatedRequest, res: Response) => {
  try{
    const { id } = req.params;
    const category = await CategoryModel.findOne({where: {id}});
    if(!category) return res.status(404).json({error: 'Category not found'});
    res.status(200).json(category);
  }catch (error) {
    console.error('Error creating user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}

export const deleteCategoryById = async (req: AuthenticatedRequest, res: Response) => {
  try{
    const { id } = req.params;
    const category = await CategoryModel.findOne({where: {id}});
    if(!category) return res.status(404).json({error: 'Category not found'});
    await category.destroy();
    res.status(200).json({message: 'Category deleted'});
  }catch (error) {
    console.error('Error creating user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}

export const updateCategoryById = async (req: AuthenticatedRequest, res: Response) => {
  try{
    const { id } = req.params;
    const { name } = req.body;
    const category = await CategoryModel.findOne({where: {id}});
    if(!category) return res.status(404).json({error: 'Category not found'});
    if(name) category.name = name;
    await category.save();
    res.status(200).json(category);
  }catch (error) {
    console.error('Error creating user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}