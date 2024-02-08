const DBConnection = require("../configs/connectDB")
const bcryptjs = require("bcryptjs");
const { use } = require("passport");

function generateRandomNumber() {
    return Math.floor(10000 + Math.random() * 90000);
  } 

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
                const randomValue = generateRandomNumber();

                let studentItem = {
                    RASTUD: randomValue.toString().padStart(5, '0'), // Format random value as string with leading zeros
                    fullname: data.fullname,
                    email: data.email,
                    password: bcryptjs.hashSync(data.password, salt)
                };

                let collaboratorItem = {
                    RACOLLAB: randomValue.toString().padStart(5, '0'), // Format random value as string with leading zeros
                    role: data.role,
                    fullname: data.fullname,
                    email: data.email,
                    password: bcryptjs.hashSync(data.password, salt),
                };

                // Use pool.query for better connection management
                // const [rows, fields] = await DBConnection.promise().query('INSERT INTO users SET ?', userItem);
                if(data.isStudent === "true"){
                    console.log("user is student")

                    const [rows, fields] = await DBConnection.query('INSERT INTO STUDENT SET ?', studentItem);
                    resolve("Create a new student successful");
                    console.log(JSON.stringify(fields))

                } if(data.isStudent === "false") {
                    console.log("user is not student")
                    const [rows, fields] = await DBConnection.query('INSERT INTO COLLABORATOR SET ?', collaboratorItem);
                    resolve("Create a new collaborator successful");
                    console.log(JSON.stringify(fields))

                }


            }
        } catch (error) {
            reject(`Error creating a new user: ${error}`);
            console.log("error adding user"+ error.message)
        }
    });
};

let checkExistEmail = (email) => {
    return new Promise(async (resolve, reject) => {
        try {
            // Use pool.query for better connection management
            // const [rows, fields] = await DBConnection.promise().query('SELECT * FROM `users` WHERE `email` = ?', [email]);
            console.log("entrei aqui checkexistemail")

            const [rows, fields] = await DBConnection.query('SELECT * FROM STUDENT WHERE EMAIL = ?', [email]);
            console.log("printando o user recuperado pela checkemailexists"+JSON.stringify(rows[0]))

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
