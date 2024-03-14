require('dotenv').config();
const express = require("express")
const configViewEngine = require("./configs/viewEngine")
const initWebRoutes = require("./routes/web")
const bodyParser = require("body-parser")
const cookieParser = require("cookie-parser")
const connectFlash = require("connect-flash")
const session = require("express-session")
const passport = require("passport")
const secureRoute = require("./routes/secureRoutes")


// const connection = require("./configs/connectDB")

// import express from "express";
// import configViewEngine from "./configs/viewEngine";
// import initWebRoutes from "./routes/web";

let app = express();

//Enable express json
app.use(express.json());

app.use(function (req, res, next) {

    // Website you wish to allow to connect
    res.setHeader('Access-Control-Allow-Origin', '*');

    // Request methods you wish to allow
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

    // Request headers you wish to allow
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

    // // Set to true if you need the website to include cookies in the requests sent
    // // to the API (e.g. in case you use sessions)
    // res.setHeader('Access-Control-Allow-Credentials', true);

    // Pass to next layer of middleware
    next();
});


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

//init secure web routes
app.use("/user", passport.authenticate('jwt', { session: false }), secureRoute);

let port = process.env.PORT || 8080;
app.listen(port, () =>console.log(`Building a login system with NodeJS is running on port ${port}!`));