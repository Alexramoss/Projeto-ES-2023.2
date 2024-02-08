const express = require("express")
const {checkLoggedIn, getLoginPage, checkLoggedOut, postLogOut } = require("../controllers/loginController")
const { getPageRegister, createNewUser } = require("../controllers/registerController")
const { getHomePage } = require("../controllers/homePageController")
const auth = require("../validation/authValidation")
const passport = require("passport")
const  { initPassportLocal }  = require("../controllers/passportLocalController")
const jwt = require('jsonwebtoken')


let router = express.Router();

initPassportLocal()

let initWebRoutes = (app) => {
    router.get("/", [checkLoggedIn, getHomePage]);
    router.get("/login", [checkLoggedOut, getLoginPage]);
    router.post("/login", (req, res, next) => {
        console.log(req.body); // Log request body
        console.log(req.flash('error')); // Log error flash messages
        console.log(req.flash('success')); // Log success flash messages
        next();
    }, passport.authenticate('login', {
        successRedirect: '/',
        failureRedirect: '/login',
        successFlash: true,
        failureFlash: true
    }));

    //secure route
    router.get(
        '/profile',
        (req, res, next) => {
            console.log(req.user)
          res.json({
            message: 'You made it to the secure route',
            user: req.user,
            token: req.query.secret_token
          })
        }
      );


    router.post(
    '/signin',
    async (req, res, next) => {
        passport.authenticate(
        'login',
        { id: req.body.id }, // Specify the key-value pair for the user id
        async (err, user, info) => {
            try {
            if (err || !user) {
                const error = new Error('An error occurred.');
                console.log(user)
                console.log(err)

                return next(error);
            }

            req.login(
                user,
                { session: false },
                async (error) => {
                if (error) return next(error);
                console.log("signin route "+ JSON.stringify(user))

                const body = { _id: user.RASTUD, email: user.EMAIL };
                console.log(JSON.stringify(body))
                const token = jwt.sign({ user: body }, 'TOP_SECRET'); 
                //You should not store sensitive information such as the user’s password in the token.

                return res.json({ token });
                }
            );
            } catch (error) {
            return next(error);
            }
        }
        )(req, res, next);
    }
    );

    router.get("/register", getPageRegister);
    // router.post("/register", auth.validateRegister, createNewUser);
    router.post("/register", createNewUser);

    router.post("/logout", postLogOut)
    return app.use("/", router);
};
module.exports = initWebRoutes;
