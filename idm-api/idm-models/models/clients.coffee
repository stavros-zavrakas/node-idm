init = (mongoose) ->
  name: "clients"
  schema:
    name:
      type: String
      required: true
    id: 
      type: String
      required: true
    secret: 
      type: String
      required: true
    uid: 
      type: mongoose.Schema.ObjectId
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
