import { DataTypes, Model } from 'sequelize';
import { sequelize } from '../../config/databaseConfigAsync';
import { v4 as uuidv4 } from 'uuid';

class NotificationModel extends Model {
  public id!: string;
  public userId!: string;
  public propertyId!: string;
  public title!: string;
  public description!: string;
}

NotificationModel.init(
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: () => uuidv4(),
      primaryKey: true,
    },
    userId: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    propertyId: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    title: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    description: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  },
  {
    sequelize,
    modelName: 'Notification',
  }
);

export default NotificationModel;
