import { DataTypes, Model } from 'sequelize';
import bcrypt from 'bcrypt';
import { sequelize } from '../../config/databaseConfigAsync';
import { v4 as uuidv4 } from 'uuid';

class CategoryModel extends Model {
  public id!: string;
  public name!: string;
  public created_at!: Date;
}

CategoryModel.init(
  {
    id: {
      type: DataTypes.UUID, 
      defaultValue: () => uuidv4(), 
      primaryKey: true, 
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    sequelize,
    modelName: 'Category',
  }
);


export default CategoryModel;
