init = (mongoose) ->
  name: "users"
  schema:
    firstName:
      type: String
      required: true
    lastName:
      type: String
      required: true
    password:
      type: String
      required: true
    email:
      type: String
      required: true
    timezone:
      type: String
    language:
      type: String
    image:
      type: String
    about:
      type: String
    gender:
      type: String
    location:
      type: String
    roles:
      type: Array
    facebook:
      type: mongoose.Schema.Types.Mixed
    google:
      type: mongoose.Schema.Types.Mixed
    twitter:
      type: mongoose.Schema.Types.Mixed
    linkedin:
      type: mongoose.Schema.Types.Mixed
    privacyPolicy:
      type: Boolean
      required: true
    isBlocked:
      type: Boolean
      default: false
    devices:
      type: Array
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