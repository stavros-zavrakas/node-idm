exports.get = 
  (usersModel) ->
    return (req, res) ->

      user = new usersModel 
        firstName: "Stavros",
        lastName: "Zavrakas"

      user.save (err) ->
        res.json
          title: "Users get"
