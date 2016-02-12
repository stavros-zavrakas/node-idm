init = (mongoose) ->
  name: "codes"
  schema:
    value: 
      type: String
      required: true
    redirectUri: 
      type: String
      required: true
    uid: 
      type: mongoose.Schema.ObjectId
      required: true
    clientId: 
      type: String
      required: true
    ### 
    permissions: 
      type: Array,
    isDeleted: 
      type: Boolean
      default: false
    created:
      type: Date
      default: Date.now
    updated:
      type: Date
      default: Date.now
    ### 

module.exports =
  init: init
