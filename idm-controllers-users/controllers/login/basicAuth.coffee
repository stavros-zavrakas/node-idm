module.exports = (passport) ->
  (req, res) ->
    console.log "successful auth"

    res.json success: true
