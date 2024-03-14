const express = require('express');
const router = express.Router();
const  { authCollaborator } = require("../validation/authCollaborator")
const auth = require("../validation/authValidation")
const { getPageRegister, createNewUser } = require("../controllers/registerController")
const classeController = require("../controllers/classeController");


router.get( // remember that the path needs to be preceded by a '/user'
  '/profile',
  (req, res, next) => {
    res.json({
      message: 'You made it to the secure route',
      user: req.user,
      token: req.query.secret_token
    })
    console.log(JSON.stringify(req.user))

  }
);

router.post("/register", [authCollaborator, auth.validateRegister], createNewUser);

// Rota para criar uma nova classe
router.post("/classes", authCollaborator, classeController.createClass);

// Rota para obter todas as classes com filtros
router.get("/classes", authCollaborator, classeController.getAllClasses);


module.exports = router;