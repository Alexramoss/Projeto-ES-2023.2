require('dotenv').config();
const express = require("express")
const configViewEngine = require("./configs/viewEngine")
const initWebRoutes = require("./routes/web")
const bodyParser = require("body-parser")
const cookieParser = require("cookie-parser")
const connectFlash = require("connect-flash")
const session = require("express-session")
const passport = require("passport")

// const connection = require("./configs/connectDB")

// import express from "express";
// import configViewEngine from "./configs/viewEngine";
// import initWebRoutes from "./routes/web";

let app = express();

const classeRoutes = require("./routes/web");

//Enable body parser post data
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

//use cookie parser
app.use(cookieParser('secret'));

//config session
app.use(session( {
    secret: 'secret',
    resave: true,
    saveUninitialized: false,
    cookie: {
        maxAge: 1000 * 60 * 60 * 24 // 1 day
    }
}));

//Enable flash message
app.use(connectFlash());

//Config view engine
configViewEngine(app);

//Config passport middleware;
app.use(passport.initialize());
app.use(passport.session());

// init all web routes
initWebRoutes(app);

let port = process.env.PORT || 8080;
app.listen(port, () =>console.log(`Building a login system with NodeJS is running on port ${port}!`));