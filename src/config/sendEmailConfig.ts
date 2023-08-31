import { generateAccessToken } from "../helper/generateAccessToken";

const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  service: 'Gmail', // e.g., 'Gmail'
  auth: {
    user: 'long.hakly19@kit.edu.kh',
    pass: 'zdcqkvwvlrhysyci',
  },
});

export const sendConfirmationEmail = (to:any) => {
  const confirmationLink = `http://localhost:8000/confirm/${to.id}`;
  const mailOptions = {
    from: 'long.hakly19@kit.edu.kh',
    to: to.email,
    subject: 'Confirm Your Email',
    text: `Please click the following link to confirm your email: ${confirmationLink}`,
  };

  transporter.sendMail(mailOptions, (error:any, info:any) => {
    if (error) {
      console.error('Error sending email:', error);
    } else {
      console.log('Email sent:', info.response);
    }
  });
}

export const sendForgotPasswordEmail = (to:any) => {
  const confirmationLink = `http://localhost:8000/user/changepassword/${to.id}`;
  const mailOptions = {
    from: 'long.hakly19@kit.edu.kh',
    to: to.email,
    subject: 'Forgot Password Email',
    text: `Please click the following link to change your password: ${confirmationLink}`,
  };

  transporter.sendMail(mailOptions, (error:any, info:any) => {
    if (error) {
      console.error('Error sending email:', error);
    } else {
      console.log('Email sent:', info.response);
    }
  });
}

