// const DBConnection = require("../configs/connectDB")
// const bcryptjs = require("bcryptjs");
// const { use } = require("passport");

// function generateRandomNumber() {
//     return Math.floor(10000 + Math.random() * 90000);
//   } 


// let createNewUser = (data) => {
//     return new Promise(async (resolve, reject) => {
//         try {
//             // Check if email already exists
//             let emailExists = await checkExistEmail(data.email, data.isStudent);

//             if (emailExists) {
//                 reject(`This email register "${data.email}" already exists. Please choose another email.`);
//                 return; // Make sure to return after rejecting the promise
//             }

//             // Hash password
//             let salt = bcryptjs.genSaltSync(10);

//             const randomValue = generateRandomNumber();

//             let userItem = {
//                 fullname: data.fullname,
//                 email: data.email,
//                 password: bcryptjs.hashSync(data.password, salt)
//             };

//             if (data.isStudent === "true") {
//                 userItem.RASTUD = randomValue.toString().padStart(5, '0');
//             } else {
//                 userItem.RACOLLAB = randomValue.toString().padStart(5, '0');
//                 userItem.role = data.role;
//             }

//             // Execute the appropriate SQL query based on user type
//             const query = data.isStudent === "true" ?
//                 'INSERT INTO STUDENT SET ?' :
//                 'INSERT INTO COLLABORATOR SET ?';

//             console.log("passei logo antes de add")
//             const [rows, fields] = await DBConnection.query(query, userItem);
//             console.log(JSON.stringify(fields)); // Log fields to inspect the response from the database

//             if (rows.affectedRows > 0) {
//                 const message = data.isStudent === "true" ?
//                     "Create a new student successful" :
//                     "Create a new collaborator successful";

//                 console.log("passei logo depois de add")

//                 resolve(message);
//             } else {
//                 reject("Error: No rows affected");
//             }
//         } catch (error) {
//             reject(`Error creating a new user: ${error}`);
//             console.error("Error adding user", error); // Log the error for debugging
//         }
//     });
// };

// let checkExistEmail = (email, isStudent) => {
//     return new Promise(async (resolve, reject) => {
//         try {
//             // Use pool.query for better connection management
//             // const [rows, fields] = await DBConnection.promise().query('SELECT * FROM `users` WHERE `email` = ?', [email]);
//             console.log("entrei aqui checkexistemail")
//             let [row, fields] = []

//             if(isStudent === "true") {
//                 [rows, fields] = await DBConnection.query('SELECT * FROM STUDENT WHERE EMAIL = ?', [email]);
//                 console.log("printando o user recuperado pela checkemailexists"+JSON.stringify(rows[0]))
//                 resolve(rows.length > 0);
//             } 
//             if(isStudent === "false") {
//                 [rows, fields] = await DBConnection.query('SELECT * FROM COLLABORATOR WHERE EMAIL = ?', [email]);
//                 console.log("printando o user recuperado pela checkemailexists"+JSON.stringify(rows[0]))
//                 resolve(rows.length > 0);
//             } 
            
//             // resolve(rows.length > 0);
//         } catch (error) {
//             reject(`Error checking email existence: ${error}`);
//             console.log(error.message)

//         }
//     });
// };




// module.exports = {
//     createNewUser: createNewUser,
// };


const DBConnection = require("../configs/connectDB");
const bcryptjs = require("bcryptjs");

function generateRandomNumber() {
    return Math.floor(10000 + Math.random() * 90000);
}

let createNewUser = async (data) => {
    try {
        console.log("Creating a new user...");
        
        // Check if email already exists
        let emailExists = await checkExistEmail(data.email, data.isStudent);

        if (emailExists) {
            throw new Error(`This email "${data.email}" is already registered. Please choose another email.`);
        }

        console.log("Email is unique. Proceeding with user creation...");

        let salt = bcryptjs.genSaltSync(10);

        let userItem = {
            fullname: data.fullname,
            email: data.email,
            password: bcryptjs.hashSync(data.password, salt)
        };

        let randomValue;
        let inserted = false;

        while (!inserted) {
            randomValue = generateRandomNumber();

            if (data.isStudent === "false") {
                userItem.RACOLLAB = data.isStudent === "false" ? randomValue.toString().padStart(5, '0') : null;
                userItem.role = data.role;
            }

            if (data.isStudent === "true") {
                userItem.RASTUD = data.isStudent === "true" ? randomValue.toString().padStart(5, '0') : null;
            }

            console.log("Generated random value:", randomValue);
            console.log("Attempting to insert user with data:", userItem);

            try {
                const query = data.isStudent === "true" ?
                    'INSERT INTO STUDENT SET ?' :
                    'INSERT INTO COLLABORATOR SET ?';

                const [rows, fields] = await DBConnection.query(query, userItem);

                if (rows.affectedRows > 0) {
                    inserted = true;
                    console.log("User inserted successfully!");
                }
            } catch (error) {
                if (error.code === 'ER_DUP_ENTRY') {
                    console.log("Duplicate entry error. Trying again...");
                    continue;
                } else {
                    throw error;
                }
            }
        }

        const message = data.isStudent === "true" ?
            "Create a new student successful" :
            "Create a new collaborator successful";

        console.log("User creation successful.");
        return message;
    } catch (error) {
        console.error("Error creating a new user:", error);
        throw new Error(`Error creating a new user: ${error}`);
    }
};

let checkExistEmail = async (email, isStudent) => {
    try {
        console.log("Checking if email exists...");
        
        let query = isStudent === "true" ?
            'SELECT COUNT(*) AS count FROM STUDENT WHERE EMAIL = ?' :
            'SELECT COUNT(*) AS count FROM COLLABORATOR WHERE EMAIL = ?';

        const [rows] = await DBConnection.query(query, [email]);
        const emailExists = rows[0].count > 0;

        console.log("Email exists:", emailExists);
        return emailExists;
    } catch (error) {
        console.error("Error checking email existence:", error);
        throw new Error(`Error checking email existence: ${error}`);
    }
};

module.exports = {
    createNewUser
};
