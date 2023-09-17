import { Request, Response } from 'express';
import NotificationModel from './model';
import PropertyModel from '../property/models';
import { JwtPayload } from 'jsonwebtoken';
interface AuthenticatedRequest extends Request {
    user?: JwtPayload;
  }
export const getAllNotifications = async (req: AuthenticatedRequest, res: Response) => {
    try {
        const notifications = await NotificationModel.findAll({where : {userId: req.user?.id}});
        for(let noti of notifications){
            const property = await PropertyModel.findOne({where: {id: noti.propertyId}});
            noti.dataValues.image = property?.image;
        }
        res.json(notifications);
    } catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}
export const getNotificationByPropertyId = async (req: AuthenticatedRequest, res: Response) => {
    try {
        const { id } = req.params;
        const notifications = await NotificationModel.findOne({where : {id: id}});
        res.json(notifications);
    }
    catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}
