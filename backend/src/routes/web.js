const express = require("express")
const {checkLoggedIn, getLoginPage, checkLoggedOut, postLogOut } = require("../controllers/loginController")
const { getPageRegister, createNewUser } = require("../controllers/registerController")
const { getHomePage } = require("../controllers/homePageController")
const auth = require("../validation/authValidation")
const passport = require("passport")
const  { initPassportLocal }  = require("../controllers/passportLocalController")


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
    }, passport.authenticate('local', {
        successRedirect: '/',
        failureRedirect: '/login',
        successFlash: true,
        failureFlash: true
    }));
    router.get("/register", getPageRegister);
    router.post("/register", auth.validateRegister, createNewUser);
    router.post("/logout", postLogOut)
    return app.use("/", router);
};
module.exports = initWebRoutes;
