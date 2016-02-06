init = (mongoose) ->
  name: "tokens"
  schema:
    accessToken:
      type: String
      required: true
    refreshToken:
      type: String
      required: true
    uid:
      type: String
      required: true
    cid:
      type: String
      required: true
    expires_in:
      type: String
      required: true
    isDeleted: 
      type: Boolean
      default: false
    created:
      type: Date
      default: Date.now
    updated:
      type: Date
      default: Date.now

module.exports =
  init: init
