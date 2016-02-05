exports.getSingle = 
  (usersModel) ->
    return (req, res) ->
      console.log "get /users/:uid controller"

      uid = req.params.uid;

      usersModel.findOne _id: uid, (err, data) ->
        res.json data
