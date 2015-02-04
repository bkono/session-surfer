logger = require '../config/logger'
mongoose = require 'mongoose'
SurfSession = mongoose.model 'SurfSession'
SurfSessionModel = require './surf-session.model'

module.exports = SurfSessionService =

  create: (session, cb) ->
    newSession = new SurfSession(session)
    newSession.save (err, saved) -> cb err, saved

  firstOrCreate: (session, cb) ->
    SurfSession.findOneAndUpdate {_id: session._id, startTime: session.startTime},
      session, {upsert: true}, (err, session) -> cb err, session

  get: (id, cb) ->
    SurfSession.findOne {_id: id}, (err, session) -> cb err, session
