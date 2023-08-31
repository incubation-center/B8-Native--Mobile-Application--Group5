import express from 'express';
import { authenticateToken } from '../../helper/authenticationToken';
import { createCategory, getAllCategory, getCategoryById, deleteCategoryById, updateCategoryById } from './controller';
const router = express.Router();

router.post('/', authenticateToken, createCategory)
router.get('/all', authenticateToken, getAllCategory)
router.get('/:id', authenticateToken, getCategoryById)
router.delete('/:id', authenticateToken, deleteCategoryById)
router.put('/:id', authenticateToken, updateCategoryById)

export default router;