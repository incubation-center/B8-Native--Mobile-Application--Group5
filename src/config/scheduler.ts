import cron from 'node-cron'
import { sendNotification } from '../helper/sendNotification';
import PropertyModel from '../app/property/models';
import UserModel from '../app/user/models';
import NotificationModel from '../app/notification/model';
const { Op } = require('sequelize');

//run every 8AM
cron.schedule('* * * * *', async () => {
    //send notification for expired products to user
    try {
        console.log("called")
        const properties = await PropertyModel.findAll({
            where: {
                expired_at: {
                    [Op.lte]: new Date()
                },
                isExpired: false
            }
        });
        for (const property of properties) {
            const user = await UserModel.findOne({ where: { id: property.userId } });
            if (user && user.deviceToken !== null) {
                sendNotification(user.deviceToken, 'Property Expired', `${property.name} has expired`);
                property.isExpired = true;
                await  property.save();
                await NotificationModel.create({ userId: user.id, propertyId: property , title: 'Property Expired', description: `${property.name} has expired` });
            }
        }
    } catch (error) {
        console.error('Error', error);
    }
    //send notification for future expired products to user
    try {
        const currentDate = new Date();
        const properties = await PropertyModel.findAll({
            where: {
                expired_at: {
                    [Op.gt]: currentDate,
                },
                isExpired: false
            }
        });
        for (const property of properties) {
            let future_expired = currentDate;
            if (property.alert_at === 0){
                future_expired = new Date(future_expired.getTime() + (7 * 24 * 60 * 60 * 1000));
            } else{
                future_expired = new Date(future_expired.getTime() + (property.alert_at * 24 * 60 * 60 * 1000));
            }
        
            if (future_expired > property.expired_at){
                const user = await UserModel.findOne({ where: { id: property.userId } });
                if (user && user.deviceToken !== null) {
                    const remaindingDays = Math.floor((property.expired_at.getTime() - currentDate.getTime()) / (1000 * 3600 * 24));
                    sendNotification(user.deviceToken, 'Property Expired Soon', `${property.name} will expire in ${remaindingDays} days`);
                    await NotificationModel.create({ userId: user.id, propertyId: property , title: 'Property Expired Soon', description: `${property.name} will expire in ${remaindingDays} days` });
                }
            }
        }
    } catch (error) {
        console.error('Error', error);
    }
});
