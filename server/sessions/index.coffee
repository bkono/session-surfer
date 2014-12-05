logger       = require '../config/logger'
auth         = require '../config/auth'
express      = require 'express'
Session     = require './sessions.model'
router       = express.Router()

router.post '/', auth.none, (req, res) ->
  logger.info 'creating new session'
  session = new Session
    startTime: req.body.startTime
  session.save (err, saved) ->
    return logger.error err if err
    logger.log "Saved a new session #{saved}"
    res.send err, saved

module.exports = router
