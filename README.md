# B8-Native--Mobile-Application--Group5
<!-- To run the project -->
step 1 : install package
- npm install

step 2 : create file ".env" in the level equal package.json with this code in side.
#DON'T FORGET TO ADJUST YOUR LOCAL DB CREDENTIAL

CODE HERE
    """
    TOKEN_SECRET = QWERTYUIOPASDFGHJKLZXCVBNM
    PORT = 8000

    #ADD YOUR
    DATABASE_NAME = DATABASE_NAME
    DATABASE_USER = DATABASE_USER 
    DATABASE_PASSWORD = DATABASE_PASSWORD
    """
step 3 : change db config in file path "src/config/databaseConfigAsync.ts"
- if you are using mysql
export const sequelize = new Sequelize(DATABASE_NAME, DATABASE_USERNAME, DATABASE_PASSWORD, {
  host: 'localhost',
  dialect: 'mysql',
  logging: false,
});

- if you are using postgresql
export const sequelize = new Sequelize(DATABASE_NAME, DATABASE_USERNAME, DATABASE_PASSWORD, {
  host: 'localhost',
  dialect: 'postgres',
  logging: false,
});

step 4 : run project
- npm start

step 5 : give me money for help install backend >,< => ABA 002597984