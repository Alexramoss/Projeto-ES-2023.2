// authCollaborator.js

// Middleware to check if the user is a collaborator
const authCollaborator = (req, res, next) => {
    // Check if the user is authenticated and their role is "collaborator"
    if (req.user && req.user.role === "collaborator") {
      // User is a collaborator, allow access to the route
      
      next();
    } else {
      // User is not authorized, respond with a 403 Forbidden error
      res.status(403).json({ message: 'Unauthorized access' });
      
    }
  };
  
  module.exports = { authCollaborator };
  