import express from 'express';
import { authenticateToken } from '../../helper/authenticationToken';
import { createProperty, deletePropertyById, getAllProperty, getPropertyById, updatePropertyById, getAllPropertyExpired} from './controller';
const router = express.Router();

router.post('/', authenticateToken, createProperty)
router.get('/all', authenticateToken, getAllProperty)
router.get('/:id', authenticateToken, getPropertyById)
router.delete('/:id', authenticateToken, deletePropertyById)
router.put('/:id', authenticateToken, updatePropertyById)
router.get('/all/expired', authenticateToken, getAllPropertyExpired)

export default router;