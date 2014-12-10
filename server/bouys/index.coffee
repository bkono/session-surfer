logger  = require '../config/logger'
auth    = require '../config/auth'
express = require 'express'
BouyService = require './bouys.service'
router  = express.Router()

router.get '/', auth.none, (req, res) ->
  logger.info 'get all bouys'
  BouyService.getBouys (err, bouys) ->
    res.send err, bouys

router.put '/sync', auth.none, (req, res) ->
  logger.info 'updating all bouys'
  BouyService.syncBouys (err, success) ->
    successRes = {msg: 'success'} unless err?
    res.send err, successRes

module.exports = router
