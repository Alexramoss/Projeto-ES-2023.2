const DBConnection = require("../configs/connectDB")
const bcryptjs = require("bcryptjs");
const { use } = require("passport");

function generateRandomNumber() {
    return Math.floor(10000 + Math.random() * 90000);
  } 

// let createNewUser = (data) => {
//     return new Promise(async (resolve, reject) => {
//         try {
//             // Check if email already exists
//             let emailExists = await checkExistEmail(data.email, data.isStudent);

//             if (emailExists) {
//                 reject(`This email register "${data.email}" already exists. Please choose another email.`);
//             } else {
//                 // Hash password
//                 let salt = bcryptjs.genSaltSync(10);
//                 const randomValue = generateRandomNumber();

//                 let studentItem = {
//                     RASTUD: randomValue.toString().padStart(5, '0'), // Format random value as string with leading zeros
//                     fullname: data.fullname,
//                     email: data.email,
//                     password: bcryptjs.hashSync(data.password, salt)
//                 };

//                 let collaboratorItem = {
//                     RACOLLAB: randomValue.toString().padStart(5, '0'), // Format random value as string with leading zeros
//                     role: data.role,
//                     fullname: data.fullname,
//                     email: data.email,
//                     password: bcryptjs.hashSync(data.password, salt),
//                 };

//                 // Use pool.query for better connection management
//                 // const [rows, fields] = await DBConnection.promise().query('INSERT INTO users SET ?', userItem);
//                 if(data.isStudent === "true"){
//                     console.log("user is student")

//                     const [rows, fields] = await DBConnection.query('INSERT INTO STUDENT SET ?', studentItem);
//                     resolve("Create a new student successful");
//                     console.log(JSON.stringify(fields))

//                 } if(data.isStudent === "false") {
//                     console.log("user is not student")
//                     const [rows, fields] = await DBConnection.query('INSERT INTO COLLABORATOR SET ?', collaboratorItem);
//                     resolve("Create a new collaborator successful");
//                     console.log(JSON.stringify(fields))

//                 }


//             }
//         } catch (error) {
//             reject(`Error creating a new user: ${error}`);
//             console.log("error adding user"+ error.message)
//         }
//     });
// };
let createNewUser = (data) => {
    return new Promise(async (resolve, reject) => {
        try {
            // Check if email already exists
            let emailExists = await checkExistEmail(data.email, data.isStudent);

            if (emailExists) {
                reject(`This email register "${data.email}" already exists. Please choose another email.`);
                return; // Make sure to return after rejecting the promise
            }

            // Hash password
            let salt = bcryptjs.genSaltSync(10);
            const randomValue = generateRandomNumber();

            let userItem = {
                fullname: data.fullname,
                email: data.email,
                password: bcryptjs.hashSync(data.password, salt)
            };

            if (data.isStudent === "true") {
                userItem.RASTUD = randomValue.toString().padStart(5, '0');
            } else {
                userItem.RACOLLAB = randomValue.toString().padStart(5, '0');
                userItem.role = data.role;
            }

            // Execute the appropriate SQL query based on user type
            const query = data.isStudent === "true" ?
                'INSERT INTO STUDENT SET ?' :
                'INSERT INTO COLLABORATOR SET ?';

            console.log("passei logo antes de add")
            const [rows, fields] = await DBConnection.query(query, userItem);
            console.log(JSON.stringify(fields)); // Log fields to inspect the response from the database

            if (rows.affectedRows > 0) {
                const message = data.isStudent === "true" ?
                    "Create a new student successful" :
                    "Create a new collaborator successful";

                console.log("passei logo depois de add")

                resolve(message);
            } else {
                reject("Error: No rows affected");
            }
        } catch (error) {
            reject(`Error creating a new user: ${error}`);
            console.error("Error adding user", error); // Log the error for debugging
        }
    });
};

let checkExistEmail = (email, isStudent) => {
    return new Promise(async (resolve, reject) => {
        try {
            // Use pool.query for better connection management
            // const [rows, fields] = await DBConnection.promise().query('SELECT * FROM `users` WHERE `email` = ?', [email]);
            console.log("entrei aqui checkexistemail")
            let [row, fields] = []

            if(isStudent === "true") {
                [rows, fields] = await DBConnection.query('SELECT * FROM STUDENT WHERE EMAIL = ?', [email]);
                console.log("printando o user recuperado pela checkemailexists"+JSON.stringify(rows[0]))
                resolve(rows.length > 0);
            } 
            if(isStudent === "false") {
                [rows, fields] = await DBConnection.query('SELECT * FROM COLLABORATOR WHERE EMAIL = ?', [email]);
                console.log("printando o user recuperado pela checkemailexists"+JSON.stringify(rows[0]))
                resolve(rows.length > 0);
            } 
            
            // resolve(rows.length > 0);
        } catch (error) {
            reject(`Error checking email existence: ${error}`);
            console.log(error.message)

        }
    });
};

module.exports = {
    createNewUser: createNewUser
};
