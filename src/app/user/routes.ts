import express from 'express';
import { getUsers, createUser, loginUser, getUserById, updateUserById, getUser, verifyEmail, forgotpassword, changepassword } from './controllers';
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
router.get('/confirm/:id', verifyEmail);
router.post('/user/forgotpassword', forgotpassword);
router.post('/user/changepassword/:id', changepassword);
export default router;