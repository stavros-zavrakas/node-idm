# @todo: find a way to chain it with passport
module.exports = (passport) ->
  (req, res) ->
    console.log "successful auth"

    res.json success: true
