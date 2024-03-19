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
const createClassesTableQuery = `
CREATE TABLE IF NOT EXISTS CLASS(
  IDCLASS INT PRIMARY KEY AUTO_INCREMENT,
  CLASSNAME VARCHAR(100) NOT NULL,
  LETTER VARCHAR(100) NOT NULL,
  MODALITY VARCHAR(100) NOT NULL
)`;

const createStudentsTableQuery = `
CREATE TABLE IF NOT EXISTS STUDENT(
  RASTUD VARCHAR(255) PRIMARY KEY UNIQUE,
  ID_CLASS INT,
  FULLNAME VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(100) NOT NULL,
  PASSWORD VARCHAR(255) NOT NULL,
  FOREIGN KEY (ID_CLASS) REFERENCES CLASS(IDCLASS)
)`;

const createCollaboratorsTableQuery = `
CREATE TABLE IF NOT EXISTS COLLABORATOR(
  RACOLLAB VARCHAR(255) PRIMARY KEY UNIQUE,
  FULLNAME VARCHAR(100) NOT NULL,
  ROLE VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(100),
  PASSWORD VARCHAR(255) NOT NULL
)`;

const createTeachersTableQuery = `
CREATE TABLE IF NOT EXISTS TEACHER(
  RATEACH VARCHAR(255) PRIMARY KEY UNIQUE,
  FULLNAME VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(100),
  PASSWORD VARCHAR(255) NOT NULL
)`;

const createMattersTableQuery = `
CREATE TABLE IF NOT EXISTS MATTER(
  MATTER VARCHAR(255),
  RA_TEACH VARCHAR(255),
  ID_CLASS VARCHAR(255),
  FOREIGN KEY(RA_TEACH) REFERENCES TEACHER(RATEACH)
)`;


// Connect to MySQL to check if the database exists
(async () => {
  let connection;
  try {
    connection = await pool.getConnection();

    console.log('Connected to MySQL!!! ******');

    // Check if the database exists
    const databaseName = 'chef_db';
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
      console.log("using " + databaseName)
    }

    console.log(`Using database: ${databaseName}`);

    // Execute the table creation query
    const [createClassTableResults] = await connection.query(createClassesTableQuery);
    console.log('Table created successfully:', createClassTableResults);
    const [createStudentTableResults] = await connection.query(createStudentsTableQuery);
    console.log('Table created successfully:', createStudentTableResults);
    const [createCollaboratorTableResults] = await connection.query(createCollaboratorsTableQuery);
    console.log('Table created successfully:', createCollaboratorTableResults);
    const [createTeacherTableResults] = await connection.query(createTeachersTableQuery);
    console.log('Table created successfully:', createTeacherTableResults);
    const [createMatterTableResults] = await connection.query(createMattersTableQuery);
    console.log('Table created successfully:', createMatterTableResults);

  } catch (err) {
    console.error('Error:', err);
  } finally {
    // Release the connection back to the pool
    if (connection) connection.release();
    // Don't close the pool here; it should be closed when your application exits
  }
})();

module.exports = pool;
