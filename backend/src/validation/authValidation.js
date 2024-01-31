const { body } = require("express-validator");

var validateRegister = [
    body("email", "Invalid email").isEmail().trim(),

    body("password", "Invalid password. Password must be at least 2 chars long")
        .isLength({ min: 2 }),

    body("confirmationPassword", "Password confirmation does not match password")
        .custom((value, { req }) => value === req.body.password)
];

module.exports = {
    validateRegister: validateRegister
}
