import { Request, Response } from "express";
import UserModel from "./models";
import bcrypt from "bcrypt";
import { generateAccessToken } from "../../helper/generateAccessToken";
import { JwtPayload, decode } from "jsonwebtoken";
import {
  sendConfirmationEmail,
  sendForgotPasswordEmail,
} from "../../config/sendEmailConfig";
var passport = require("passport");

interface AuthenticatedRequest extends Request {
  user?: JwtPayload;
}

interface GoogleAuthenticatedRequest extends Request {
  user?: UserModel;
}

interface SessionRequest extends Request {
  session?: any;
}

export const getUsers = async (req: AuthenticatedRequest, res: Response) => {
  try {
    if (req.user?.role != "ADMIN") {
      return res.status(403).json({ error: "Forbidden" });
    }
    const users = await UserModel.findAll();
    res.json(users);
  } catch (error) {
    console.error("Error fetching users from the database:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const getUser = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const user = req.user;
    res.json(user);
  } catch (error) {
    console.error("Error fetching user from the database:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const getUserById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const user = await UserModel.findOne({ where: { id } });
    if (!user) return res.status(404).json({ error: "User not found" });
    res.json(user);
  } catch (error) {
    console.error("Error fetching user from the database:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const updateUserById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const { username, email, password, role } = req.body;
    const user = await UserModel.findOne({ where: { id } });
    if (!user) return res.status(404).json({ error: "User not found" });
    if (username) user.username = username;
    if (email) user.email = email;
    if (password) {
      const salt = await bcrypt.genSalt();
      const hashedPassword = await bcrypt.hash(password, salt);
      user.password = hashedPassword;
    }
    if (role) user.role = role;
    await user.save();
    res.json(user);
  } catch (error) {
    console.error("Error updating user in the database:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const createUser = async (req: Request, res: Response) => {
  try {
    const { username, email, password1, password2 } = req.body;

    // check if user already exists
    const user = await UserModel.findOne({ where: { email } });
    if (user) return res.status(400).json({ error: "User already exists" });

    // check if user has provided all the fields
    if (!username || !email || !password1 || !password2)
      return res
        .status(400)
        .json({ error: "Please provide username, email, and password" });

    // check if email is valid
    const emailRegex =
      /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    if (!emailRegex.test(email))
      return res.status(400).json({ error: "Please provide a valid email" });

    // check if passwords match
    if (password1 !== password2)
      return res.status(400).json({ error: "Passwords do not match" });

    // create new user in the database
    const newUser = await UserModel.create({
      username,
      email,
      password: password1,
    });

    // send confirmation email
    sendConfirmationEmail(newUser);
    res.json(newUser);
  } catch (error) {
    res.status(500).json({ error: "Internal server error" });
  }
};

export const loginUser = async (req: Request, res: Response) => {
  try {
    const { email, password } = req.body;
    if (!email || !password)
      return res
        .status(400)
        .json({ error: "Please provide email and password" });

    const user = await UserModel.findOne({ where: { email } });
    if (!user)
      return res.status(400).json({ error: "No user found with that email" });
    if (user.verify != true) {
      return res
        .status(400)
        .json({ error: "Please check your email to verify your account" });
    }
    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch)
      return res.status(400).json({ error: "Invalid password" });
    const accessToken = generateAccessToken(user);
    res.status(200).json({ accessToken });
  } catch (error) {
    console.log(error);
  }
};

export const forgotpassword = async (req: Request, res: Response) => {
  try {
    const { email } = req.body;
    if (!email) return res.status(400).json({ error: "Please provide email" });
    const user = await UserModel.findOne({ where: { email } });
    if (!user)
      return res.status(400).json({ error: "No user found with that email" });
    sendForgotPasswordEmail(user);
    res.status(200).json({ message: "Email sent" });
  } catch (error) {
    console.log(error);
  }
};

export const verifyEmail = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const user = await UserModel.findOne({ where: { id } });
    if (!user) {
      return res.status(400).json({ error: "Invalid Token" });
    }
    user.verify = true;
    await user.save();
    res.status(200).json({ message: "Email verified" });
  } catch (error) {
    console.log(error);
  }
};

export const changepassword = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const { password1, password2 } = req.body;
    const user = await UserModel.findOne({ where: { id } });
    if (!user) return res.status(400).json({ error: "Invalid Token" });
    if (!password1 || !password2)
      return res.status(400).json({ error: "Please provide password" });
    if (password1 !== password2)
      return res.status(400).json({ error: "Passwords do not match" });
    const saltRounds = await bcrypt.genSalt();
    user.password = await bcrypt.hash(password1, saltRounds);
    await user.save();
    res.status(200).json({ message: "Password changed" });
  } catch (error) {
    console.log(error);
  }
};

export const updateUserDeviceToken = async (req: Request, res: Response) => {
  try {
    const { userId, deviceToken } = req.body;
    const user = await UserModel.findOne({ where: { id: userId } });
    if (!user) {
      return res.status(400).json({ error: "Invalid User" });
    }
    user.deviceToken = deviceToken;
    await user.save();
    res
      .status(200)
      .json({ user: user, message: "devicetoken updated successfully" });
  } catch (error) {
    console.error("Error updating deviceToken:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

// pass query string to passport middleware
export const passQueryString = (
  req: SessionRequest,
  res: Response,
  next: any
) => {
  // Extract the query string from the original URL
  const query = req.query;
  // Store the query parameters in the session
  req.session.query = query;
  // Continue to the authentication process
  next();
};

// retrerive query string from session and store in request
export const getQueryString = (
  req: SessionRequest,
  res: Response,
  next: any
) => {
  // Retrieve the query parameters from the session
  const query = req.session.query;
  // Remove the query parameters from the session (optional)
  delete req.session.query;
  // Store the query parameters in the request for later use
  req.query.redirect_uri = query.redirect_uri;
  // Continue to the Passport.js authentication callback
  next();
};

// auth with google using passport
export const googleRedirect = async (
  req: GoogleAuthenticatedRequest,
  res: Response
) => {
  // get redirect uri of frontend from query string
  const redirectUri = req.query.redirect_uri;

  if (redirectUri) {
    const authorizedRedirectUris =
      process.env.AUTHORIZED_REDIRECT_URIS?.split(",");
    // check if redirect uri is authorized
    if (!authorizedRedirectUris?.includes(redirectUri.toString())) {
      return res.status(400).json({ error: "Invalid redirect_uri" });
    }
  } else {
    return res.status(400).json({ error: "Missing redirect_uri" });
  }

  // get user from passport middleware
  const user = req.user;
  if (!user) {
    // redirect to frontend with error in query string
    res.redirect(`${redirectUri}?error=invalid_token`);
  } else {
    // generate access token
    const accessToken = generateAccessToken(user);
    // redirect to frontend with token in query string
    res.redirect(`${redirectUri}?token=${accessToken}`);
  }
};
