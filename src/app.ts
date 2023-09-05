import express from "express";
const session = require("express-session");
const passport = require("passport");
import dotenv from "dotenv";
import userRoutes from "./app/user/routes";
import cateRoute from "./app/category/routes";
import propertyRoute from "./app/property/routes";
import { sequelize, syncDatabase } from "./config/databaseConfigAsync";
import logRequest from "./config/apiLogConfig";
import "./config/scheduler";
import "./config/passportConfig";

dotenv.config();
const app = express();
const PORT = process.env.PORT || 5000;
console.log("PORT", PORT);

// Configure express-session middleware
app.use(
  session({
    secret: "your-secret-key", // Replace with a secure secret key
    resave: true,
    saveUninitialized: true,
  })
);

// Initialize Passport.js
app.use(passport.initialize());
app.use(passport.session());

app.use(express.json({ limit: "10mb" }));
app.use(express.urlencoded({ extended: true }));
app.use(logRequest);
app.use("/", userRoutes);
app.use("/category", cateRoute);
app.use("/property", propertyRoute);

async function startServer() {
  try {
    await sequelize.authenticate();
    await syncDatabase();
    app.listen(PORT, () => {
      console.log("Server is running on port 8000");
    });
  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
}

startServer();
