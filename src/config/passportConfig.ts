import UserModel from "../app/user/models";

var passport = require("passport");
var GoogleStrategy = require("passport-google-oauth20").Strategy;

passport.serializeUser((user: UserModel, done: any) => {
  done(null, user.id);
});

passport.deserializeUser(async (id: any, done: any) => {
  const user = await UserModel.findOne({ where: { id } });
  done(null, user);
});

passport.use(
  new GoogleStrategy(
    {
      clientID: process.env["GOOGLE_CLIENT_ID"],
      clientSecret: process.env["GOOGLE_CLIENT_SECRET"],
      callbackURL: "/oauth2/redirect/google",
      scope: ["profile"],
    },
    (accessToken: any, refreshToken: any, profile: any, done: any) => {
      // check if user already exists in our own db by email
      UserModel.findOne({
        where: { email: profile.emails[0].value },
      }).then((currentUser: any) => {
        if (currentUser) {
          // already have this user
          done(null, currentUser);
        } else {
          // if not, create user in our db
          UserModel.create({
            email: profile.emails[0].value,
            username: profile.displayName,
            password: "",
            verify: true,
          }).then((newUser: UserModel) => {
            done(null, newUser);
          });
        }
      });
    }
  )
);
