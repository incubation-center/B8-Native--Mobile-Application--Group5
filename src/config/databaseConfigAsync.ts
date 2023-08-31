import { Sequelize } from 'sequelize';
import dotenv from 'dotenv';

dotenv.config();

const DATABASE_NAME = process.env.DATABASE_NAME || 'property';
const DATABASE_USERNAME = process.env.DATABASE_USER || 'long hakly';
const DATABASE_PASSWORD = process.env.DATABASE_PASSWORD || 'A45698700a';

export const sequelize = new Sequelize(DATABASE_NAME, DATABASE_USERNAME, DATABASE_PASSWORD, {
  host: 'localhost',
  dialect: 'mysql', //postgres
  logging: false,
});
import PropertyModel from '../app/property/models';
import UserModel from '../app/user/models';
import CategoryModel from '../app/category/models';

export async function syncDatabase() {
    try {
      await sequelize.authenticate();
      await sequelize.sync();
      console.log('Database synchronized successfully.');
    } catch (error) {
      console.error('Error synchronizing the database:', error);
    }
  }
  
