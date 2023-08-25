import admin from '../config/firebaseAdmin';
export const sendNotification = async (deviceToken: string, title: string, body: string) => {
    const message = {
        notification: {
            title,
            body,
        },
        token: deviceToken,
    };
    console.log(message)
    try {
        const response = await admin.messaging().send(message);
        console.log('Successfully sent message:', response);
    } catch (error) {
        console.error('Error sending message:', error);
    }
}