const DBConnection = require("../configs/connectDB");

let getAllClasses = async (
  classname,
  letter,
  modality,
  minId,
  maxId
) => {
  try {
    let filterQuery = "SELECT * FROM CLASS WHERE 1=1";
    const queryParams = [];

    if (classname) {
      filterQuery += " AND CLASSNAME = ?";
      queryParams.push(classname);
    }

    if (letter) {
      filterQuery += " AND LETTER = ?";
      queryParams.push(letter);
    }

    if (modality) {
      filterQuery += " AND MODALITY = ?";
      queryParams.push(modality);
    }

    if (minId) {
      filterQuery += " AND IDCLASS >= ?";
      queryParams.push(minId);
    }

    if (maxId) {
      filterQuery += " AND IDCLASS <= ?";
      queryParams.push(maxId);
    }

    const [results] = await DBConnection.query(filterQuery, queryParams);
    return results;
  } catch (error) {
    throw error;
  }
};

let getClassById = async (id) => {
  try {
    const [results] = await DBConnection.query(
      "SELECT * FROM CLASS WHERE IDCLASS = ?",
      [id]
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

let createClass = async (classname, letter, modality) => {
  try {
    const [results] = await DBConnection.query(
      "INSERT INTO CLASS (CLASSNAME, LETTER, MODALITY) VALUES (?, ?, ?)",
      [classname, letter, modality]
    );
    return results.insertId;
  } catch (error) {
    throw error;
  }
};

let updateClass = async (id, classname, letter, modality) => {
  try {
    const [results] = await DBConnection.query(
      "UPDATE CLASS SET CLASSNAME = ?, LETTER = ?, MODALITY = ? WHERE IDCLASS = ?",
      [classname, letter, modality, id]
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

let deleteClass = async (id) => {
  try {
    const [results] = await DBConnection.query(
      "DELETE FROM CLASS WHERE IDCLASS = ?",
      [id]
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
  getAllClasses: getAllClasses,
  getClassById: getClassById,
  createClass: createClass,
  updateClass: updateClass,
  deleteClass: deleteClass,
};