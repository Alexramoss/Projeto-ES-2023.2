const express = require('express');
const router = express.Router();
const  { authCollaborator } = require("../validation/authCollaborator")

router.get( // remember that the path needs to be preceded by a '/user'
  '/profile',
  authCollaborator,
  (req, res, next) => {
    res.json({
      message: 'You made it to the secure route',
      user: req.user,
      token: req.query.secret_token
    })
    console.log(JSON.stringify(req.user))

  }
);

module.exports = router;