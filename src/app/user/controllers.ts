import { Request, Response } from 'express';
import UserModel from './models';
import bcrypt from 'bcrypt';
import { generateAccessToken } from '../../helper/generateAccessToken';
import { JwtPayload, decode } from 'jsonwebtoken';
import { sendConfirmationEmail, sendForgotPasswordEmail } from '../../config/sendEmailConfig';

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
    const { username, email, password1, password2 } = req.body;
    if (!username || !email || !password1 || !password2) 
      return res.status(400).json({ error: 'Please provide username, email, and password' });
    if (password1 !== password2)
      return res.status(400).json({ error: 'Passwords do not match' });
    const newUser = await UserModel.create({username, email, password : password1});

    sendConfirmationEmail(newUser)
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
    if (user.verify != true){
      return res.status(400).json({ error: 'Please your email to verify your account' });
    }
    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) 
      return res.status(400).json({ error: 'Invalid password' });
    const accessToken = generateAccessToken(user);
    res.status(200).json({ accessToken });
  } catch (error) {
    console.log(error);
  }
};

export const forgotpassword = async (req: Request, res: Response) => {
  try{
    const { email } = req.body;
    if (!email) 
      return res.status(400).json({ error: 'Please provide email' });
    const user = await UserModel.findOne({ where: { email } });
    if (!user) 
      return res.status(400).json({ error: 'No user found with that email' });
    sendForgotPasswordEmail(user);
    res.status(200).json({ message: 'Email sent' });
  } catch (error) {
    console.log(error);
  }
};

export const verifyEmail = async (req: Request, res: Response) => {
  try{
    const { id } = req.params;
    const user = await UserModel.findOne({ where: { id } });
    if (!user){
      return res.status(400).json({ error: 'Invalid Token' });
    }
    user.verify = true;
    await user.save();
    res.status(200).json({ message: 'Email verified' });
  } catch (error) {
    console.log(error);
  }
};

export const changepassword = async (req: Request, res: Response) => {
  try{
    const { id } = req.params;
    const { password1, password2 } = req.body;
    const user = await UserModel.findOne({ where: { id } });
    if (!user)
      return res.status(400).json({ error: 'Invalid Token' });
    if (!password1 || !password2) 
      return res.status(400).json({ error: 'Please provide password' });
    if (password1 !== password2)
      return res.status(400).json({ error: 'Passwords do not match' });
    const saltRounds = await bcrypt.genSalt();
    user.password = await bcrypt.hash(password1, saltRounds);
    await user.save();
    res.status(200).json({ message: 'Password changed' });
  } catch (error) {
    console.log(error);
  }
};