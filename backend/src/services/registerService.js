const DBConnection = require("../configs/connectDB")
const bcryptjs = require("bcryptjs")

// let createNewUser = (user) => {
//     return new Promise( async (resolve,reject) => {
//         try {
//             //check if email exists or not
//             //for our project:  check if student is associated to a class
//             let check = await checkEmailUser(user.email)
//             console.log(check + "!!!")


//         } catch (e) {
//             console.log("aqui!!!")
//             console.log(e.message)


//             reject(e);
//         }
//     });

// };

// let checkEmailUser = (email) => {
//     return new Promise(((resolve, reject) => {
//         try{
//             connection.query("SELECT * from users where email = ?", email, function(error, rows) {
//                 if(error) {
//                     console.log("aqui2!!!")
//                     console.log(error.message)

//                     reject(error);

//                 }
//                 if (rows.length > 0) {
//                     resolve(true)
//                 } else {
//                     resolve(false)
//                 }
//             })

//         } catch (e) {
//             console.log("aqui3!!!")
//             console.log(error.message)

//             reject(e);
//         }
//     }))
// };

// module.exports = {
//     createNewUser: createNewUser
// }


// let createNewUser = (data) => {
//     return new Promise(async (resolve, reject) => {
//         // check email is exist or not
//         let isEmailExist = await checkExistEmail(data.email);
//         if (isEmailExist) {
//             reject(`This email "${data.email}" has already exist. Please choose an other email`);
//         } else {
//             // hash password
//             let salt = bcryptjs.genSaltSync(10);
//             let userItem = {
//                 fullname: data.fullname,
//                 email: data.email,
//                 password: bcryptjs.hashSync(data.password, salt),
//             };

//             //create a new account
//             DBConnection.query(
//                 ' INSERT INTO users set ? ', userItem,
//                 function(err, rows) {
//                     if (err) {
//                         reject(false)
//                     }
//                     resolve("Create a new user successful");
//                 }
//             );
//         }
//     });
// };

// let checkExistEmail = (email) => {
//     return new Promise( (resolve, reject) => {
//         try {
//             DBConnection.query(
//                 ' SELECT * FROM `users` WHERE `email` = ?  ', email,
//                 function(err, rows) {
//                     if (err) {
//                         reject(err)
//                     }
//                     if (rows.length > 0) {
//                         resolve(true)
//                     } else {
//                         resolve(false)
//                     }
//                 }
//             );
//         } catch (err) {
//             reject(err);
//         }
//     });
// };
// module.exports = {
//     createNewUser: createNewUser
// };

// const bcryptjs = require('bcryptjs');
// const DBConnection = require('../path/to/your/connection/pool'); // Import the connection pool

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
                const [rows, fields] = await DBConnection.query('INSERT INTO users SET ?', userItem);

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
            const [rows, fields] = await DBConnection.query('SELECT * FROM `users` WHERE `email` = ?', [email]);

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
