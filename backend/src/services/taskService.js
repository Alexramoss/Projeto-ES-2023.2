const DBConnection = require("../configs/connectDB");

let getTasksById = async (ID) => {

    try {
        let query = 'SELECT * FROM TASK WHERE ID_CLASS = ?';
        [results] = DBConnection.query(query, ID)
        if (results && results != null && results != []) {
            return results;
        }
        return "Nenhuma tarefa encontrada para a turma"
    } catch(error) {
        print(error)
        throw error;


    }

}

let getTasksBy = async (paramName, paramValue) => {
    try {
        let query = `SELECT * FROM TASK WHERE ${paramName} = ?`;
        const [results] = await DBConnection.query(query, [paramValue]);

        if (results && results.length > 0) {
            return results;
        }
        return "No tasks found for the provided parameter";
    } catch (error) {
        console.log(error);
        throw error;
    }
}



let addTask = async (data) => {

    let taskItem = {
        ID_CLASS: data.idClass,
        title: data.title,
        description: data.description,
        explanation_title: data.explanationTitle,
        explanation_description: data.explanationDescription,
        status: data.status,
    }
    try {
        let query = 'INSERT INTO TASK SET ?';
        results = DBConnection.query(query, taskItem);
        return results.insertId;
    } catch (error) {
      throw error;
    
    }
}


let editTask = async (id, data) => {
    try {
        let updateFields = {}; // Initialize an empty object to store fields to update

        // Check each field in the data object
        if (data.idClass !== null && data.idClass !== undefined) {
            updateFields.id_class = data.idClass;
        }
        if (data.title !== null && data.title !== undefined) {
            updateFields.title = data.title;
        }
        if (data.description !== null && data.description !== undefined) {
            updateFields.description = data.description;
        }
        if (data.explanationTitle !== null && data.explanationTitle !== undefined) {
            updateFields.explanation_title = data.explanationTitle;
        }
        if (data.explanationDescription !== null && data.explanationDescription !== undefined) {
            updateFields.explanation_description = data.explanationDescription;
        }
        if (data.status !== null && data.status !== undefined) {
            updateFields.status = data.status;
        }

        let query = 'UPDATE TASK SET ? WHERE ID = ?';
        let [results] = await DBConnection.query(query, [updateFields, id]);
        return results.affectedRows;
    } catch (error) {
        throw error;
    }
}


let deleteTask = async (id) => {
    try {
        let query = 'DELETE FROM TASK WHERE ID = ?';

        let [results] = await DBConnection.query(query, id);
        return results.affectedRows;
    } catch (error) {
        throw error;
    }
};

module.exports = {
    getTasksById,
    addTask,
    editTask,
    getTasksBy,
    deleteTask
}