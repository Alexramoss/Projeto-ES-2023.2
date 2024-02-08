// const mysql = require("mysql2")
// require('dotenv').config()

// // Create a connection to the MySQL server
// const connection = mysql.createConnection({
//     host: 'localhost',
//     user: 'root',
//     password: 'Vik571999*',
//     waitForConnections: true,
//     connectionLimit: 10,
//     queueLimit: 0
//   });

//   const createTableQuery = `
//   CREATE TABLE IF NOT EXISTS users (
//     id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
//     email VARCHAR(45) NOT NULL,
//     password VARCHAR(255),
//     fullname VARCHAR(45)
// )`;


// // Connect to MySQL to check if the database exists
// connection.connect((err) => {
//     if (err) {
//       console.error('Error connecting to MySQL:', err);
//       return;
//     }
  
//     console.log('Connected to MySQL!!! ******');
  
//     // Check if the database exists
//     const databaseName = "demotutorial";
//     connection.query(`SHOW DATABASES LIKE '${databaseName}'`, (error, results) => {
//       if (error) {
//         console.error('Error checking database existence:', error);
//         connection.end();
//         return;
//       }
  
//       if (results.length === 0) {
//         // Database doesn't exist, create it
//         connection.query(`CREATE DATABASE ${databaseName}`, (createDatabaseError) => {
//           if (createDatabaseError) {
//             console.error('Error creating database:', createDatabaseError);
//             connection.end();
//             return;
//           }
  
//           console.log('Database created successfully');
  
//           // Switch to the created database
//           connection.query(`USE ${databaseName}`, (useDatabaseError) => {
//             if (useDatabaseError) {
//               console.error('Error switching to the created database:', useDatabaseError);
//               connection.end();
//               return;
//             }
  
//             console.log(`Using database: ${databaseName}`);
  
//             // Define your table creation SQL query
//             // const createTableQuery = `
//             //   CREATE TABLE IF NOT EXISTS users (
//             //     id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
//             //     email VARCHAR(45) NOT NULL,
//             //     password VARCHAR(255),
//             //     fullname VARCHAR(45)
//             // )`;
  
//             // Execute the table creation query
//             connection.query(createTableQuery, (createTableError, createTableResults) => {
//               if (createTableError) {
//                 console.error('Error creating table:', createTableError);
//               } else {
//                 console.log('Table created successfully:', createTableResults);
//               }
  
//               // Close the MySQL connection
//               connection.end();
//             });
//           });
//         });
//       } else {
//         // Database already exists, switch to it
//         connection.query(`USE ${databaseName}`, (useDatabaseError) => {
//           if (useDatabaseError) {
//             console.error('Error switching to the existing database:', useDatabaseError);
//             connection.end();
//             return;
//           }
  
//           console.log(`Using database: ${databaseName}`);
  
//           // Define your table creation SQL query
//         //   const createTableQuery = `
//         //       CREATE TABLE IF NOT EXISTS users (
//         //         id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
//         //         email VARCHAR(45) NOT NULL,
//         //         password VARCHAR(255),
//         //         fullname VARCHAR(45)
//         //     )`;
  
//           // Execute the table creation query
//           connection.query(createTableQuery, (createTableError, createTableResults) => {
//             if (createTableError) {
//               console.error('Error creating table:', createTableError);
//             } else {
//               console.log('Table created successfully:', createTableResults);
//             }
  
//             // Close the MySQL connection
//             // connection.end();
//           });
//         });
//       }
//     });
//   });

//   module.exports = connection;

const mysql = require('mysql2/promise');
require('dotenv').config();

// Create a connection pool to the MySQL server
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

process.on('SIGINT', async () => {
  try {
    await pool.end();
    console.log('Connection pool closed.');
    process.exit(0); // Exit the application
  } catch (err) {
    console.error('Error closing connection pool:', err);
    process.exit(1); // Exit the application with an error code
  }
});

process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
  process.exit(1); // Exit the application with an error code
});


// Define your table creation SQL query
const createStudentsTableQuery = `
CREATE TABLE IF NOT EXISTS STUDENT(
  RASTUD VARCHAR(5) PRIMARY KEY UNIQUE,
  FULLNAME VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(100) NOT NULL,
  PASSWORD VARCHAR(255) NOT NULL
)`;

// const updateStudentsTableQuery = `
// -- Drop the foreign key constraint
// ALTER TABLE STUDCLASS
// DROP FOREIGN KEY studclass_ibfk_1;
// `;

const modifyRASTUDQuery = `
-- Modify the RASTUD column in the STUDENT table
ALTER TABLE STUDENT
MODIFY RASTUD VARCHAR(255);
`;

const modifyPasswordQuery = `
-- Modify the PASSWORD column in the STUDENT table
ALTER TABLE STUDENT
MODIFY PASSWORD VARCHAR(255);
`;

const recreateForeignKeyQuery = `
-- Recreate the foreign key constraint
ALTER TABLE STUDCLASS
ADD CONSTRAINT fk_studclass_student FOREIGN KEY (RA_STUD) REFERENCES STUDENT (RASTUD);
`;


// Then execute each query separately



const createClassesTableQuery = `
CREATE TABLE IF NOT EXISTS CLASS(
  IDCLASS INT PRIMARY KEY AUTO_INCREMENT,
  CLASS CHAR(1) NOT NULL,
  LETTER CHAR(1) NOT NULL,
  MODALITY VARCHAR(13) NOT NULL
)`;

const createStudclassesTableQuery = `
CREATE TABLE IF NOT EXISTS STUDCLASS(
  ID_CLASS INT,
  RA_STUD VARCHAR(5) UNIQUE,
  CLASS CHAR(1) NOT NULL,
  LETTER CHAR(1) NOT NULL,
  MODALITY VARCHAR(13) NOT NULL,
  FOREIGN KEY(RA_STUD) REFERENCES STUDENT(RASTUD),
  FOREIGN KEY(ID_CLASS) REFERENCES CLASS(IDCLASS)
)`; 

const createCollaboratorsTableQuery = `
CREATE TABLE IF NOT EXISTS COLLABORATOR(
  RACOLLAB VARCHAR(255) PRIMARY KEY UNIQUE,
  ROLE VARCHAR(100),
  FULLNAME VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(100),
  PASSWORD VARCHAR(255) NOT NULL
)`;


// Connect to MySQL to check if the database exists
(async () => {
  let connection;
  try {
    connection = await pool.getConnection();

    console.log('Connected to MySQL!!! ******');

    // Check if the database exists
    const databaseName = 'demotutorial';
    const [results] = await connection.query(`SHOW DATABASES LIKE '${databaseName}'`);

    if (results.length === 0) {
      // Database doesn't exist, create it
      await connection.query(`CREATE DATABASE ${databaseName}`);
      console.log('Database created successfully');

      // Switch to the created database
      await connection.query(`USE ${databaseName}`);
    } else {
      // Database already exists, switch to it
      await connection.query(`USE ${databaseName}`);
    }

    console.log(`Using database: ${databaseName}`);

    // Execute the table creation query
    const [createStudentTableResults] = await connection.query(createStudentsTableQuery);
    console.log('Table created successfully:', createStudentTableResults);

    // const [alterStudentTable] = await connection.query(updateStudentsTableQuery);
    // console.log('Table altered successfully:', alterStudentTable);
    // const [alterRASTUDQuery] = await connection.query(modifyRASTUDQuery);
    // console.log('Table altered successfully:', alterRASTUDQuery);
    // const [modifyPassword] = await connection.query(modifyPasswordQuery);
    // console.log('Table altered successfully:', modifyPassword);
    // const [recreateForeignKey] = await connection.query(recreateForeignKeyQuery);
    // console.log('Table altered successfully:', recreateForeignKey);



    const [createClassTableResults] = await connection.query(createClassesTableQuery);
    console.log('Table created successfully:', createClassTableResults);
    const [createStudclassTableResults] = await connection.query(createStudclassesTableQuery);
    console.log('Table created successfully:', createStudclassTableResults);
    const [createCollaboratorTableResults] = await connection.query(createCollaboratorsTableQuery);
    console.log('Table created successfully:', createCollaboratorTableResults);

  } catch (err) {
    console.error('Error:', err);
  } finally {
    // Release the connection back to the pool
    if (connection) connection.release();
    // Don't close the pool here; it should be closed when your application exits
  }
})();

module.exports = pool;

