import { Request, Response } from 'express';
import UserModel from './models';
import bcrypt from 'bcrypt';
import { generateAccessToken } from '../../helper/generateAccessToken';
import { JwtPayload } from 'jsonwebtoken';

interface AuthenticatedRequest extends Request {
  user?: JwtPayload;
}

export const getUsers = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const users = await UserModel.findAll();
    res.json(users);
  } catch (error) {
    console.error('Error fetching users from the database:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

export const getUser = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const user = req.user;
    res.json(user);
  } catch (error) {
    console.error('Error fetching user from the database:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}

export const getUserById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const user = await UserModel.findOne({ where: { id } });
    if (!user) 
      return res.status(404).json({ error: 'User not found' });
    res.json(user);
  } catch (error) {
    console.error('Error fetching user from the database:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

export const updateUserById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const { username, email, password, role } = req.body;
    const user = await UserModel.findOne({ where: { id } });
    if (!user) 
      return res.status(404).json({ error: 'User not found' });
    if (username) user.username = username;
    if (email) user.email = email;
    if (password){
      const salt = await bcrypt.genSalt();
      const hashedPassword = await bcrypt.hash(password, salt);
      user.password = hashedPassword;
    } 
    if (role) user.role = role;
    await user.save();
    res.json(user);
  } catch (error) {
    console.error('Error updating user in the database:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

export const createUser = async (req: Request, res: Response) => {
  try {
    const { username, email, password } = req.body;
    if (!username || !email || !password) 
      return res.status(400).json({ error: 'Please provide username, email, and password' });
    const newUser = await UserModel.create({username, email, password});
    res.json(newUser);
  } catch (error) {
    console.error('Error creating user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

export const loginUser = async (req: Request, res: Response) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) 
      return res.status(400).json({ error: 'Please provide email and password' });

    const user = await UserModel.findOne({ where: { email } });
    if (!user) 
      return res.status(400).json({ error: 'No user found with that email' });
    
    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) 
      return res.status(400).json({ error: 'Invalid password' });
    const accessToken = generateAccessToken(user);
    res.status(200).json({ accessToken });
  } catch (error) {
    console.log(error);
  }
};
