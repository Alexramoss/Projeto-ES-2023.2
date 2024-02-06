const passport = require("passport")
const passportLocal = require("passport-local")
const loginService = require("../services/loginService")
const JWTstrategy = require('passport-jwt').Strategy;
const ExtractJWT = require('passport-jwt').ExtractJwt;

let localStrategy = passportLocal.Strategy
console.log("PASSEI AQUI")

let initPassportLocal = () => {
    passport.use('login',new localStrategy({
        usernameField: 'email',
        passwordField: 'password',
        passReqToCallback: true 
    }, 
        async (req, email, password, done) => {
            console.log("PASSEI AQUI2")

            try {
                console.log("problema aqui5")

                let user = await loginService.findUserByEmail(email);
                if(!user){
                    console.log("problema aqui")
                    // return done(null, false, req.flash("errors", `This user email "${email}"" does not exist`))
                    return done(null, false, { message: `This user email "${email}"" does not exist` })

                }
                console.log("problema aqui4")

                if(user) {
                    //compare password
                    let match = await loginService.comparePasswordUser(user, password)
                    if (match === true){
                        console.log("problema aqui2")

                        // return done(null, user, null)
                        
                        return done(null, user, { message: "Successfully logged in"})

                    } else {
                        console.log("problema aqui3")

                        // return done(null, false, req.flash("errors", match))
                        return done(null, false, { message: "Wrong password"})


                    }
                }
            } catch (err) {
                console.log(err)

                return done(null, false, err)
            }
        }
        
        ));
}

passport.serializeUser((user, done) => {
    done(null, user.id);
    
});

passport.deserializeUser((id, done) => {
    loginService.findUserById(id).then((user) => {
        return done(null, user);
    }).catch(error => {
        return done(error, null)
    });
});



passport.use(
  new JWTstrategy(
    {
      secretOrKey: 'TOP_SECRET',
      jwtFromRequest: ExtractJWT.fromUrlQueryParameter('secret_token')
    },
    async (token, done) => {
      try {
        return done(null, token.user);
      } catch (error) {
        done(error);
      }
    }
  )
);
new JWTstrategy(
    {
      secretOrKey: 'TOP_SECRET',
      jwtFromRequest: ExtractJWT.fromUrlQueryParameter('secret_token')
    },
    async (token, done) => {
      try {
        if (!token.user) {
          return done(null, false, { message: 'User not found in token' });
        }
        return done(null, token.user);
      } catch (error) {
        return done(error);
      }
    }
  )

  

module.exports = {
    initPassportLocal: initPassportLocal
}