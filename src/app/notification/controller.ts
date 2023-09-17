import { Request, Response } from 'express';
import NotificationModel from './model';
import { JwtPayload } from 'jsonwebtoken';
interface AuthenticatedRequest extends Request {
    user?: JwtPayload;
  }
export const getAllNotifications = async (req: AuthenticatedRequest, res: Response) => {
    try {
        const notifications = await NotificationModel.findAll({where : {userId: req.user?.id}});
        res.json(notifications);
    } catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}