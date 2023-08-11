import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
dotenv.config();
const TOKEN_SECRET = process.env.TOKEN_SECRET || "";
export const generateAccessToken = (user : object) => {
    const payload = { user };
    return jwt.sign(payload, TOKEN_SECRET, { expiresIn: '1800s' });
  }