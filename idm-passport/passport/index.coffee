passport = require "passport"

basicStrategy = require "./basicStrategy"
clientBasicStrategy = require "./clientBasicStrategy"
bearerStrategy = require "./bearerStrategy"

init = (Users, Clients, Tokens) ->

  passport.serializeUser (user, done) ->
    done null, user

  passport.deserializeUser (obj, done) ->
    done null, obj

  basicStrategy passport, Users
  clientBasicStrategy passport, Clients
  bearerStrategy passport, Users, Tokens

  return passport

module.exports =
  init: init