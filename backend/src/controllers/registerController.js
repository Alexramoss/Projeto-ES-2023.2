const { validationResult } = require("express-validator");
const registerService = require("../services/registerService")
const editUserService = require("../services/editUserService")



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
        return res.json({
            message: 'Signup error',
            errors: errorsArr
            

        })
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
        console.log("New user created:" + JSON.stringify(newUser))
        return res.json({
            message: 'Signup successful',
            fullname: newUser.fullname, 
            password: newUser.password
            

        })
    } catch (err) {
        req.flash("errors", err);
        return res.json({
            message: 'Signup failed',
            errors: err, 
            
            

        })
    }
};

let studentsRegister = async (req, res) => { //the "register" a student does after he's already been registered by a collaborator
    const { RASTUD } = req.params;
    // const { PASSWORD } = req.body;
    let PASSWORD = req.body.password;
    let ISSTUDENT = req.body.isStudent;


    try {
       await editUserService.updatePassword(RASTUD, PASSWORD, ISSTUDENT)
      res.json({ message: 'Password updated successfully' });

    // } catch (err) {
    //     req.flash("errors", err);
    } catch (err) {
        res.status(err.status || 500).json({ error: err.message || 'Internal server error' });
    // }
    
    }

}
module.exports = {
    getPageRegister: getPageRegister,
    createNewUser: createNewUser,
    studentsRegister
};