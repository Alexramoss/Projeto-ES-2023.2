const taskService = require("../services/taskService");

// let getTasksByClass = async (req, res) => {
//     const { ID } = req.params;

//     try {
//          [results] = await taskService.getTasksByClass(ID);
         
//          res.json(results)
//     } catch(e) {
//         console.log(e);
//         res.status(500).json({ message: "Internal Server Error" });
//     }

// };

// let getTasksByStatus = async (req, res) => {
//     const { status } = req.body;

//     try {
        
//         const results = await taskService.getTasksByStatus(status);
        
//         res.json(results);
//     } catch (e) {
//         console.log(e);
//         res.status(500).json({ message: "Internal Server Error" });
//     }
// };

let getTasksByClass = async (req, res) => {
    const { ID_CLASS } = req.params;


    try {
        const results = await taskService.getTasksBy('ID_CLASS', ID_CLASS);
        res.json(results);
    } catch (e) {
        console.log(e);
        res.status(500).json({ message: "Internal Server Error" });
    }
};

let getTasksByStatus = async (req, res) => {
    const { status } = req.query;

    try {
        const results = await taskService.getTasksBy('STATUS', status);
        res.json(results);
    } catch (e) {
        console.log(e);
        res.status(500).json({ message: "Internal Server Error" });
    }
};

let addTask = async (req, res) => {
    newTask = {
        idClass: req.body.idClass,
        title: req.body.title,
        description: req.body.description,
        explanationTitle: req.body.explanationTitle,
        explanationDescription: req.body.explanationDescription,
        status: req.body.status,
    }
    console.log(newTask)

    try {
        results = await taskService.addTask(newTask);
        res
        .status(201)
        .json({ message: "Task created successfully"});
    } catch(e) {
        console.log(e)
        throw(e)

    }

}

let editTask = async (req, res) => {
    const { ID } = req.params; 

    task = {
        idClass: req.body.idClass,
        title: req.body.title,
        description: req.body.description,
        explanationTitle: req.body.explanationTitle,
        explanationDescription: req.body.explanationDescription,
        status: req.body.status,
    }

    try {
        const affectedRows = await taskService.editTask(ID, task);

        if (affectedRows > 0) {
            res.json({ message: "Task updated successfully" });
        } else {
            res.status(404).json({ message: "No task found with the provided ID" });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};


let deleteTask = async (req, res) => {
    const { ID } = req.params; 

    try {
        const affectedRows = await taskService.deleteTask(ID);

        if (affectedRows > 0) {
            res.json({ message: "Task deleted successfully" });
        } else {
            res.status(404).json({ message: "No task found with the provided ID" });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};


// CREATE TABLE IF NOT EXISTS TASK(
//   ID INT PRIMARY KEY AUTO_INCREMENT,
//   ID_CLASS INT,
//   TITLE VARCHAR(255) NOT NULL,
//   DESCRIPTION VARCHAR(255) NOT NULL,
//   EXPLANATION_TITLE VARCHAR(255) NOT NULL,
//   EXPLANATION_DESCRIPTION VARCHAR(255) NOT NULL,
//   STATUS VARCHAR(255) NOT NULL,
//   FOREIGN KEY (ID_CLASS) REFERENCES CLASS(IDCLASS)


module.exports = {
    getTasksByClass,
    addTask,
    editTask,
    getTasksByStatus,
    deleteTask

}