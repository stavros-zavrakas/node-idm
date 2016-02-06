get = require "./controllers/get"
getSingle = require "./controllers/getSingle"
post = require "./controllers/post"

module.exports = (options, imports, register) ->
  console.log "users controllers initialized"

  usersModel = imports.usersModel

  get = get.get usersModel
  getSingle = getSingle.getSingle usersModel
  post = post.post usersModel

  register null,
    usersControllers:
      get: get
      getSingle: getSingle
      post: post
