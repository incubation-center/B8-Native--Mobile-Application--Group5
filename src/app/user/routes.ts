import express from 'express';
import { getUsers, createUser, loginUser, getUserById, updateUserById, getUser } from './controllers';
import { authenticateToken } from '../../helper/authenticationToken';
const router = express.Router();

router.get('/', async (req, res) => {
    res.send("Server is running!");
});
router.post('/login', loginUser);
router.get('/user/all', authenticateToken, getUsers);
router.post('/user', createUser);
router.get('/user', authenticateToken, getUser);
router.get('/user/:id', authenticateToken, getUserById);
router.put('/user/:id', authenticateToken, updateUserById);
export default router;