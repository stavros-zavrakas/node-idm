init = (mongoose) ->
  clientName:
    type: String
    required: true
  clientId: 
    type: String
    required: true
  clientSecret: 
    type: String
    required: true
  uid: 
    type: mongoose.Schema.ObjectId
    required: true
  permissions: 
    type: Array,
  isDeleted: 
    type: Boolean
    default: false

module.exports =
  init: init
