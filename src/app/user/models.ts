import { DataTypes, Model } from 'sequelize';
import bcrypt from 'bcrypt';
import { sequelize } from '../../config/databaseConfigAsync';
import { v4 as uuidv4 } from 'uuid';
import CategoryModel from '../category/models';
class UserModel extends Model {
  public id!: string;
  public username!: string;
  public email!: string;
  public password!: string;
  public role!: string;
  public verify!: boolean;
}

UserModel.init(
  {
    id: {
      type: DataTypes.UUID, 
      defaultValue: () => uuidv4(), 
      primaryKey: true, 
    },
    username: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    role: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: 'USER',
    },
    verify: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: false,
    },
  },
  {
    sequelize,
    modelName: 'User',
  }
);

UserModel.beforeCreate(async (user: UserModel) => {
  const saltRounds = await bcrypt.genSalt();
  user.password = await bcrypt.hash(user.password, saltRounds);
});

// Define the association
UserModel.hasMany(CategoryModel, {
  foreignKey: 'userId', 
  as: 'categories', 
});

export default UserModel;
