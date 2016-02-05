mongoose = require "mongoose"

schema = new mongoose.Schema
  firstName: 'string'
  lastName: 'string'
  password: 'string'
  email: 'string'
  timezone: 'string'
  language: 'string'
  image: 'string'
  about: 'string'
  gender: 'string'
  location: 'string'
  roles: 'string'
  facebookUser: 'string'
  googleUser: 'string'
  twitterUser: 'string'
  linkedinUser: 'string'
  privacyPolicy: 'string'
  isBlocked: 'string'
  isDeleted: 'string'
  devices: 'string'
  created: 'string'
  updated: 'string'

users = mongoose.model "users", schema

module.exports = {
  model: users
}