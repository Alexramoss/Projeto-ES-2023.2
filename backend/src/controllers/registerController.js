const { validationResult } = require("express-validator");
const registerService = require("../services/registerService")

// let getRegisterPage = (req, res) => {
//     res.render("register.ejs", {
//         errors: req.flash("errors")
//     })
// }

// let createNewUser = (req, res) => {
//     //validate all required fields 
//     let errorsArr = [];
//     let validationErrors = validationResult(req);
//     if (!validationErrors.isEmpty()) {
//         let errors = Object.values(validationErrors.mapped());
//         errors.forEach((item) => {
//             errorsArr.push(item.msg);
//         });

//         req.flash("errors", errorsArr);
//         return res.redirect("/register");

//     }
    
//     //create a new user
//     try {
//         let newUser = {
//             fullname: req.body.fullname,
//             email: req.body.email,
//             password: req.body.password
//         }

//         await registerService.createNewUser(newUser);
//         return res.redirect("/login");

//     } catch (e) {
//         req.flash("errors", errorsArr);
//         return res.redirect("/register");
 
//     }

// }

// module.exports = {
//     getRegisterPage: getRegisterPage,
//     createNewUser: createNewUser
// }

// import registerService from "./../services/registerService";
// import { validationResult } from "express-validator";

let getPageRegister = (req, res) => {
    return res.render("register.ejs", {
        errors: req.flash("errors")
    });
};

let createNewUser = async (req, res) => {
    //validate required fields
    let errorsArr = [];
    let validationErrors = validationResult(req);
    if (!validationErrors.isEmpty()) {
        let errors = Object.values(validationErrors.mapped());
        errors.forEach((item) => {
            errorsArr.push(item.msg);
        });
        req.flash("errors", errorsArr);
        return res.redirect("/register");
    }

    //create a new user
    let newUser = {
        fullname: req.body.fullName,
        email: req.body.email,
        password: req.body.password,
        isStudent: req.body.isStudent,
        role: req.body.role
    };
    try {
        await registerService.createNewUser(newUser);
        // return res.redirect("/login");
        print("New user created:" + JSON.stringify(newUser))
        return res.json({
            message: 'Signup successful',
            fullname: newUser.fullname, 
            password: newUser.password
            

        })
    } catch (err) {
        req.flash("errors", err);
        return res.redirect("/register");
    }
};
module.exports = {
    getPageRegister: getPageRegister,
    createNewUser: createNewUser
};