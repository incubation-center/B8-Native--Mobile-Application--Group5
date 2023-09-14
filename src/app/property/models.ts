import { DataTypes, Model } from 'sequelize';
import { sequelize } from '../../config/databaseConfigAsync';
import { v4 as uuidv4 } from 'uuid';
import UserModel from '../user/models';
import CategoryModel from '../category/models';

class PropertyModel extends Model {
  public id!: string;
  public name!: string;
  public expired_at!: Date;
  public alert_at!: number;
  public image!: string;
  public price!: number;
  public isDeleted!: boolean;
  public isExpired!: boolean;
  public userId!: string;
  public categoryId!: string;
}

PropertyModel.init(
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
    expired_at: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    alert_at: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 0,
    },
    image: {
      type: DataTypes.STRING,
      allowNull: true,
    },  
    price: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    userId: {
      type: DataTypes.UUID,
      allowNull: false,
      references: {
        model: UserModel,
        key: 'id',
      },
    },
    categoryId: {
      type: DataTypes.UUID,
      allowNull: false,
      references: {
        model: CategoryModel,
        key: 'id',
      },
    },    
    isDeleted: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    isExpired: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    }
  },
  {
    sequelize,
    modelName: 'Property',
  }
);

PropertyModel.belongsTo(UserModel, { foreignKey: 'userId', as: 'user' });
PropertyModel.belongsTo(CategoryModel, { foreignKey: 'categoryId', as: 'category' });

export default PropertyModel;
