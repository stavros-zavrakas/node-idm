module.exports = 
  (usersModel) ->
    return (req, res) ->
      console.log "get /users controller"

      usersModel.find {}, (err, data) ->
        res.json data
