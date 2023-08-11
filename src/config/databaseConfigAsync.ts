import { Sequelize } from 'sequelize';
import dotenv from 'dotenv';

dotenv.config();

const DATABASE_NAME = process.env.DATABASE_NAME || 'database_name';
const DATABASE_USERNAME = process.env.DATABASE_USER || 'username';
const DATABASE_PASSWORD = process.env.DATABASE_PASSWORD || 'password';

export const sequelize = new Sequelize(DATABASE_NAME, DATABASE_USERNAME, DATABASE_PASSWORD, {
  host: 'localhost',
  dialect: 'postgres',
  logging: false,
});

export async function syncDatabase() {
    try {
      await sequelize.authenticate();
      await sequelize.sync();
      console.log('Database synchronized successfully.');
    } catch (error) {
      console.error('Error synchronizing the database:', error);
    }
  }
  
