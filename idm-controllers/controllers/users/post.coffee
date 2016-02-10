module.exports = 
  (usersModel) ->
    return (req, res) ->
      console.log "post /users controller"

      user = new usersModel 
        firstName: req.body.firstName
        lastName: req.body.lastName
        privacyPolicy: req.body.privacyPolicy
        email: req.body.email
        password: req.body.password

      user.save (err, data) ->
        res.json data
