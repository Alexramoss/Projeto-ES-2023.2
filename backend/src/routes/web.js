const express = require("express")
const {checkLoggedIn, getLoginPage, checkLoggedOut, postLogOut } = require("../controllers/loginController")
const { getPageRegister, createNewUser } = require("../controllers/registerController")
const { getHomePage } = require("../controllers/homePageController")
const auth = require("../validation/authValidation")
const passport = require("passport")
const  { initPassportLocal }  = require("../controllers/passportLocalController")
let router = express.Router();
const classeController = require("../controllers/classeController");
const teachersController = require("../controllers/teachersController")
const noteController = require("../controllers/notesController");
const eventsController = require("../controllers/eventsController");
const mattersController = require("../controllers/mattersController");

initPassportLocal()

let initWebRoutes = (app) => {
    router.get("/", [checkLoggedIn, getHomePage]);
    router.get("/login", [checkLoggedOut, getLoginPage]);
    router.post("/login", (req, res, next) => {
        console.log(req.body); // Log request body
        console.log(req.flash('error')); // Log error flash messages
        console.log(req.flash('success')); // Log success flash messages
        next();
    }, passport.authenticate('local', {
        successRedirect: '/',
        failureRedirect: '/login',
        successFlash: true,
        failureFlash: true
    }));
    router.get("/register", getPageRegister);
    router.post("/register", auth.validateRegister, createNewUser);
    router.post("/logout", postLogOut)
    return app.use("/", router);
};
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


// Rota para obter todas as notas com filtros
router.get("/notes", noteController.getAllNotes);

// Rota para obter uma única nota por RASTUD
router.get("/notes/:RASTUD", noteController.getNoteByRASTUD);

// Rota para criar uma nova nota
router.post("/notes", noteController.createNote);

// Rota para atualizar uma nota por RASTUD
router.put("/notes/:RASTUD", noteController.updateNote);

// Rota para excluir uma nota por RASTUD
router.delete("/notes/:RASTUD", noteController.deleteNote);

router.get("/events", eventsController.getAllEvents);

router.get("/events/:rateach", eventsController.getEventByRaTeacher);

router.post("/events", eventsController.createEvent);

router.put("/events/:id", eventsController.updateEvent);

router.delete("/events/:id", eventsController.deleteEvent);

router.get("/matters", mattersController.getAllMatters);

router.get("/matters/:idclass", mattersController.getMatterByRaTeacher);

router.post("/matters", mattersController.createMatter);

router.put("/matters/:idclass", mattersController.updateMatter);

router.delete("/matters/:idclass", mattersController.deleteMatter);


module.exports = router;
module.exports = initWebRoutes;
