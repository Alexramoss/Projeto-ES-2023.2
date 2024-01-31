const loginController = require("../controllers/loginController")

let getHomePage = (req, res) => {
    // if(!req.isAuthenticated()){
    //     return res.redirect("/login");
    // }
    return res.render("homepage.ejs", {
        user: req.user
    });
};
module.exports = {
    getHomePage: getHomePage
} 