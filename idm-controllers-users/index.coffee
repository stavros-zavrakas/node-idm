get = require "./controllers/get"
getSingle = require "./controllers/getSingle"
post = require "./controllers/post"

module.exports = (options, imports, register) ->
  console.log "users controllers initialized"

  usersModel = imports.usersModel
  getUsersController = get.get usersModel
  getSingleUsersController = getSingle.getSingle usersModel
  postUsersController = post.post usersModel

  register null,
    getUsersController: getUsersController
    getSingleUsersController: getSingleUsersController
    postUsersController: postUsersController
