import express from 'express';
import dotenv from 'dotenv';
import userRoutes from './app/user/routes';
import { sequelize, syncDatabase } from './config/databaseConfigAsync';
import logRequest from './config/apiLogConfig';
dotenv.config();
const app = express();
const PORT = process.env.PORT || 5000;
console.log('PORT', PORT);
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(logRequest);
app.use('/', userRoutes);

async function startServer() {
  try {
    await sequelize.authenticate();
    await syncDatabase();
    app.listen(PORT, () => {
      console.log('Server is running on port 8000');
    });
  } catch (error) {
    console.error('Unable to connect to the database:', error);
  }
}
startServer();
