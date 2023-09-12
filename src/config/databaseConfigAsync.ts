import { Sequelize } from "sequelize";
import dotenv from "dotenv";

// Determine the environment from NODE_ENV
const environment = process.env.NODE_ENV || "development";

// Load the appropriate .env file
dotenv.config({ path: `.env.${environment}` });

const DATABASE_HOST = process.env.DATABASE_HOST || "localhost";
const DATABASE_NAME = process.env.DATABASE_NAME || "property";
const DATABASE_USERNAME = process.env.DATABASE_USER || "long hakly";
const DATABASE_PASSWORD = process.env.DATABASE_PASSWORD || "A45698700a";

export const sequelize = new Sequelize(
  DATABASE_NAME,
  DATABASE_USERNAME,
  DATABASE_PASSWORD,
  {
    host: DATABASE_HOST,
    dialect: "postgres",
    logging: false,
    ssl: true,
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false,
      },
    },
  }
);
import PropertyModel from "../app/property/models";
import UserModel from "../app/user/models";
import CategoryModel from "../app/category/models";

export async function syncDatabase() {
  try {
    await sequelize.authenticate();
    await sequelize.sync();
    console.log("Database synchronized successfully.");
  } catch (error) {
    console.error("Error synchronizing the database:", error);
  }
}
