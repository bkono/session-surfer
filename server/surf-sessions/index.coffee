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

router.put '/', auth.none, (req, res) ->
  session =
    startTime: new Date req.body.startTime
    endTime: new Date req.body.endTime
    ratings: req.body.ratings

  SurfSession.findOneAndUpdate {
    _id: req.body._id, startTime: session.startTime,
  }, session, {upsert: true},
  (err, updated) ->
    return logger.error err && res.send err if err
    logger.info "Saved a new session #{updated}"
    res.send updated

module.exports = router
