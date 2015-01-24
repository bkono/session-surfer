logger  = require '../config/logger'
auth    = require '../config/auth'
express = require 'express'
WaveBouyService = require './wave-bouys.service'
router  = express.Router()

router.get '/', auth.none, (req, res) ->

module.exports = router
