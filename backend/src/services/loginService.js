// const DBConnection = require("../configs/connectDB")
// const bcryptjs = require("bcryptjs");

// let findUserByEmail = (email) => {
//     return new Promise((resolve, reject) => {
//         try {
//             console.log('problema')
//             DBConnection.query(
//                 ' SELECT * FROM `users` WHERE `email` = ?  ', email,
//                 function(err, rows) {
//                     if (err) {
//                         reject(err)
//                         console.log('problema1')

//                     }
//                     let user = rows[0];
//                     resolve(user);
//                     console.log('problema2')

//                 }
//             );
//         } catch (err) {
//             reject(err);
//             console.log('problema3')

//         }
//     });
// };
// // let findUserByEmail = (email) => {
// //     console.log("finduserByEmail")
// //     console.log(email)
// //     return new Promise(((resolve, reject) => {
// //         console.log("finduserByEmail2")

// //         try {
// //             console.log("finduserByEmail3")

// //             DBConnection.query(' SELECT * FROM `users` WHERE `email` = ? ', email, function(error, rows) {
// //                 console.log("finduserByEmail4")

// //                 if(error) {
// //                     console.log("finduserByEmail5")

// //                     reject(error);
// //                     console.log(error.message)

// //                 }
// //                 let user = rows[0];
// //                 console.log("finduserByEmail6")

// //                 resolve(user);
// //                 console.log(user)

// //             })
// //         }catch (e) {
// //             reject(e);
// //             console.log(e.message)

// //         }
// //     }));

// // }

// let comparePasswordUser = (user, password) => {
//     return new Promise(async (resolve, reject) => {
//         try {
//            let isMatch =  await bcryptjs.compare(password, user.password);
//            if(isMatch) resolve(true);
//            reject("The password you've entered is incorrect")
//         } catch (e) {
//             reject(e)
//             console.log(e.message)
//         }
//     })

// }

// let findUserById = (id) => {
//     return new Promise((resolve, reject)=> {
//         try {
//             DBConnection.query("SELECT * from users where id = ?", id, function(error, rows) {
//                 if(error) reject(error);
//                 let user = rows[0];
//                 resolve(user)
//                 console.log(user)
//             })

//         } catch (e) {
//             reject(e)
//             console.log(e.message)

//         }
//     })

// }

// module.exports =  {
//     findUserByEmail: findUserByEmail,
//     comparePasswordUser: comparePasswordUser,
//     findUserById: findUserById
// };

const DBConnection = require("../configs/connectDB");
const bcryptjs = require("bcryptjs");

let findUserByEmail = (email) => {
  return new Promise(async (resolve, reject) => {
    try {
      console.log("email parametro find by email" + email)
      console.log('tentando conectar com student e procurar por email');
      const [rows] = await DBConnection.query(
        'SELECT * FROM `STUDENT` WHERE `EMAIL` = ?',
        [email]
      );
      

      let user = rows[0];
     
      resolve(user);
      console.log("printando o user recuperado pela find by email"+ user)
      console.log(JSON.stringify(user))

    } catch (err) {
      reject(err);
      console.log(err.message);
    }
  });
};

let comparePasswordUser = (user, password) => {
  return new Promise(async (resolve, reject) => {
    console.log("PASSWORD" + password)
    console.log("PASSWORD  11" + JSON.stringify(user))

    try {
      let isMatch = await bcryptjs.compare(password, user.PASSWORD);
      if (isMatch) resolve(true);
      resolve("The password you've entered is incorrect");
    } catch (e) {
      reject(e);
      console.log(e.message);
    }
  });
};

let findUserById = (id) => {
  return new Promise(async (resolve, reject) => {
    try {
      const [rows] = await DBConnection.query(
        "SELECT * FROM STUDENT WHERE RASTUD = ?",
        [id]
      );

      let user = rows[0];
      resolve(user);
    } catch (e) {
      reject(e);
      console.log(e.message);
    }
  });
};

module.exports = {
  findUserByEmail: findUserByEmail,
  comparePasswordUser: comparePasswordUser,
  findUserById: findUserById,
};
