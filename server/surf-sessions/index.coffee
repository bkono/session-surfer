logger  = require '../config/logger'
auth    = require '../config/auth'
express = require 'express'
SurfSession = require './surf-session.model'
router  = express.Router()

router.post '/', auth.none, (req, res) ->
  session = new SurfSession
    startTime: new Date(req.body.startTime)
  session.save (err, saved) ->
    return logger.error err && res.send err if err
    logger.info "Saved a new session #{saved}"
    res.send saved

module.exports = router
