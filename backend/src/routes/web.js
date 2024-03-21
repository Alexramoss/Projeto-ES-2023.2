const express = require("express")
const {checkLoggedIn, getLoginPage, checkLoggedOut, postLogOut } = require("../controllers/loginController")
const { getPageRegister, createNewUser, editUserPassword } = require("../controllers/registerController")
const { getHomePage } = require("../controllers/homePageController")
const auth = require("../validation/authValidation")
const passport = require("passport")
const  { initPassportLocal }  = require("../controllers/passportLocalController")
const jwt = require('jsonwebtoken')
let router = express.Router();
const classeController = require("../controllers/classeController");
const teachersController = require("../controllers/teachersController")
const taskController = require("../controllers/taskController");

initPassportLocal()

let initWebRoutes = (app) => {
    router.get("/", [checkLoggedIn, getHomePage]);
    router.get("/login", [checkLoggedOut, getLoginPage]);
    router.post("/login", (req, res, next) => {
        console.log(req.body); // Log request body
        console.log(req.flash('error')); // Log error flash messages
        console.log(req.flash('success')); // Log success flash messages
        next();
    }, passport.authenticate('login', {
        successRedirect: '/',
        failureRedirect: '/login',
        successFlash: true,
        failureFlash: true
    }));



    router.post(
    '/signin',
    async (req, res, next) => {
        passport.authenticate(
        'login',
        { id: req.body.id }, // Specify the key-value pair for the user id
        async (err, user, info) => {
            try {
            if (err || !user) {
                const error = new Error('An error occurred.');
                console.log(user)
                console.log(err)
                console.log(info)

                return next(error);
            }

            req.login(
                user,
                { session: false },
                async (error) => {
                if (error) return next(error);
                console.log("signin route "+ JSON.stringify(user))

                const body = { id: (user.RASTUD || user.RACOLLAB), email: user.EMAIL, role: req.body.role, name:user.FULLNAME, idclass: user.IDCLASS };
                console.log(JSON.stringify(body))
                console.log(req.user.role)
                const token = jwt.sign({ user: body }, 'TOP_SECRET'); 
                //You should not store sensitive information such as the user’s password in the token.

                return res.json({ token });
                }
            );
            } catch (error) {
            return next(error);
            }
        }
        )(req, res, next);
    }
    );
// Rota para obter todas as classes com filtros
router.get("/classes", classeController.getAllClasses);

// Rota para obter uma única classe por ID
router.get("/classes/:id", classeController.getClassById);

// Rota para criar uma nova classe
router.post("/classes", classeController.createClass);

// Rota para atualizar uma classe por ID
router.put("/classes/:id", classeController.updateClass);

// Rota para excluir uma classe por ID
router.delete("/classes/:id", classeController.deleteClass);


// Rota para obter todas as teacher
router.get("/teachers", teachersController.getAllTeachers);

// Rota para obter uma única teacher por RATEACH
router.get("/teachers/:rateach", teachersController.getTeacherByRatech);

// Rota para criar uma nova teacher
router.post("/teachers", teachersController.createTeacher);

// Rota para atualizar uma teacher por RATEACH
router.put("/teachers/:rateach", teachersController.updateTeacher);

// Rota para excluir uma teacher por RATEACH
router.delete("/teachers/:rateach", teachersController.deleteTeacher);

 router.post("/register", auth.validateRegister, createNewUser);

    // router.post("/register", createNewUser);
router.put("/editpassword/:ID", auth.validatePasswordUpdate, editUserPassword); //when the student creates its own password
router.post("/logout", postLogOut)

router.get("/students/:ID_CLASS", classeController.getAllStudentsOfClass);

router.post("/task", taskController.addTask);

router.put("/edittask/:ID", taskController.editTask);

router.get("/task/:ID_CLASS", taskController.getTasksByClass);
router.get("/task", taskController.getTasksByStatus);


router.delete("/task/:ID", taskController.deleteTask);


    return app.use("/", router);
};



module.exports = router;
module.exports = initWebRoutes;