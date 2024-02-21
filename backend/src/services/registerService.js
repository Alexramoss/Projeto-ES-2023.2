const DBConnection = require("../configs/connectDB")
const bcryptjs = require("bcryptjs")

let createNewUser = (data) => {
    return new Promise(async (resolve, reject) => {
        try {
            // Check if email already exists
            let emailExists = await checkExistEmail(data.email);

            if (emailExists) {
                reject(`This email register "${data.email}" already exists. Please choose another email.`);
            } else {
                // Hash password
                let salt = bcryptjs.genSaltSync(10);
                let userItem = {
                    fullname: data.fullname,
                    email: data.email,
                    password: bcryptjs.hashSync(data.password, salt),
                };

                // Use pool.query for better connection management
                // const [rows, fields] = await DBConnection.promise().query('INSERT INTO users SET ?', userItem);
                const [rows, fields] = await DBConnection.query('INSERT INTO student SET ?', userItem);

                resolve("Create a new user successful");
            }
        } catch (error) {
            reject(`Error creating a new user: ${error}`);
            console.log(error.message)
        }
    });
};

let checkExistEmail = (email) => {
    return new Promise(async (resolve, reject) => {
        try {
            // Use pool.query for better connection management
            // const [rows, fields] = await DBConnection.promise().query('SELECT * FROM `users` WHERE `email` = ?', [email]);
            const [rows, fields] = await DBConnection.query('SELECT * FROM `student` WHERE `email` = ?', [email]);

            resolve(rows.length > 0);
        } catch (error) {
            reject(`Error checking email existence: ${error}`);
            console.log(error.message)

        }
    });
};

module.exports = {
    createNewUser: createNewUser
};