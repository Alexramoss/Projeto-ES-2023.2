const { body } = require("express-validator");

var validateUserCreation = [
    body("email", "Invalid email").isEmail().trim(),

    body("fullName", "Nome inválido").isLength({min: 3})
];

var editUser = [ //not working yet
    body("password", "Invalid password. Password must be at least 2 chars long").isLength({ min: 2 }),
    body("confirmationPassword", "Password confirmation does not match password").custom((value, { req }) => {
        console.log("Value of confirmationPassword:", value);
        console.log("Value of req.body.password:", req.body.password);
        return value === req.body.password;
    })
];

module.exports = {
    validateRegister: validateUserCreation,
    validatePasswordUpdate: editUser
}
