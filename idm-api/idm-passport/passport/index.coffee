passport = require "passport"

localStrategy = require "./localStrategy"
basicStrategy = require "./basicStrategy"
clientBasicStrategy = require "./clientBasicStrategy"
bearerStrategy = require "./bearerStrategy"
facebookStrategy = require "./facebookStrategy"

init = (config, Users, Clients, Tokens) ->

  passport.serializeUser (user, done) ->
    done null, user

  passport.deserializeUser (obj, done) ->
    done null, obj

  localStrategy passport, Users
  basicStrategy passport, Users
  clientBasicStrategy passport, Clients
  bearerStrategy passport, Users, Tokens
  facebookStrategy passport, config, Users

  return passport

module.exports =
  init: init