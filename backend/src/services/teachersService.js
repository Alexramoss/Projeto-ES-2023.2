const DBConnection = require("../configs/connectDB");

let getAllTeachers = async (
  rateach,
  fullname,
  email,
) => {
  try {
    let filterQuery = "SELECT * FROM TEACHER WHERE 1=1";
    const queryParams = [];

    if (rateach) {
      filterQuery += " AND RATEACH = ?";
      queryParams.push(rateach);
    }

    if (fullname) {
      filterQuery += " AND FULLNAME = ?";
      queryParams.push(fullname);
    }

    if (email) {
      filterQuery += " AND EMAIL = ?";
      queryParams.push(email);
    }
    const [results] = await DBConnection.query(filterQuery, queryParams);
    return results;
  } catch (error) {
    throw error;
  }
};

let getTeacherByRatech = async (rateach) => {
  try {
    const [results] = await DBConnection.query(
      "SELECT * FROM TEACHER WHERE IDCLASS = ?",
      [rateach]
    );
    if (results.length > 0) {
      return results[0];
    } else {
      return null;
    }
  } catch (error) {
    throw error;
  }
};

let createTeacher = async (rateach, fullname, email) => {
  try {
    const [results] = await DBConnection.query(
      "INSERT INTO TEACHER (rateach, fullname, email) VALUES (?, ?, ?)",
      [rateach, fullname, email]
    );
    return results.insertId;
  } catch (error) {
    throw error;
  }
};

let updateTeacher = async (rateach, fullname, email) => {
  try {
    const [results] = await DBConnection.query(
      "UPDATE TEACHER SET FULLNAME = ?, EMAIL = ? WHERE RATEACH = ?",
      [fullname, email, rateach]
    );
    if (results.affectedRows > 0) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    throw error;
  }
};

let deleteTeacher = async (rateach) => {
  try {
    const [results] = await DBConnection.query(
      "DELETE FROM TEACHER WHERE RATEACH = ?",
      [rateach]
    );
    if (results.affectedRows > 0) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    throw error;
  }
};


module.exports = {
  getAllTeachers: getAllTeachers,
  getTeacherByRatech: getTeacherByRatech,
  createTeacher: createTeacher,
  updateTeacher: updateTeacher,
  deleteTeacher: deleteTeacher,
};