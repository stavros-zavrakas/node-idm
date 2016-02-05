exports.post = 
  (usersModel) ->
    return (req, res) ->
      console.log "post /users controller"

      user = new usersModel 
        firstName: req.body.firstName,
        lastName: req.body.lastName

      user.save (err, data) ->
        res.json data
