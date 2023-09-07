import express from "express";
import {
  getUsers,
  createUser,
  loginUser,
  getUserById,
  updateUserById,
  getUser,
  verifyEmail,
  forgotpassword,
  changepassword,
  googleRedirect,
  passQueryString,
  getQueryString,
} from "./controllers";
import { authenticateToken } from "../../helper/authenticationToken";
const router = express.Router();
const passport = require("passport");

router.get("/", async (req, res) => {
  res.send("Server is running!");
});
router.post("/login", loginUser);
router.get("/user/all", authenticateToken, getUsers);
router.post("/user", createUser);
router.get("/user", authenticateToken, getUser);
router.get("/user/:id", authenticateToken, getUserById);
router.put("/user/:id", authenticateToken, updateUserById);
router.get("/confirm/:id", verifyEmail);
router.post("/user/forgotpassword", forgotpassword);
router.put("/user/changepassword/:id", changepassword);
// auth with google
router.get(
  "/auth/google",
  passQueryString,
  passport.authenticate("google", {
    scope: ["profile", "email"],
  })
);
// callback route for google to redirect to
// hand control to passport to use code to grab profile info
router.get(
  "/oauth2/redirect/google",
  getQueryString,
  passport.authenticate("google"),
  googleRedirect
);

export default router;
