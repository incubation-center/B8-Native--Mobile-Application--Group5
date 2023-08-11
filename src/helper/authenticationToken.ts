import jwt, { JwtPayload, VerifyErrors } from 'jsonwebtoken';
import { Request, Response, NextFunction } from 'express';

interface AuthenticatedRequest extends Request {
  user?: JwtPayload;
}

export const authenticateToken = (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (token == null) return res.sendStatus(401);
  jwt.verify(token, process.env.TOKEN_SECRET as string, (err: any, user: JwtPayload | any) => {
    if (err) 
        return res.sendStatus(403);
    if (!user) 
        return res.sendStatus(403);
    req.user = user.user;
    next();
  });
};
