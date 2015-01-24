logger = require '../config/logger'
http = require 'http'
changeCase = require 'change-case'
lo = require 'lodash'
mongoose = require 'mongoose'
events = global.eventServer

WaveBouyModel = require './wave-bouy.model'
WaveBouy = mongoose.model 'WaveBouy'
WaveBouyParser = require './wave-bouys.parser'
CurrentWaveBouyReadings = require './current-wave-bouys.service'

currentReadings = new CurrentWaveBouyReadings()
currentReadings.on 'waveBouy:newReading', (waveBouy) ->
  WaveBouyService.createOrUpdateBouy waveBouy, (error, waveBouy) ->
    logger.error error if error
    logger.debug "persisted new bouy reading #{JSON.stringify(waveBouy)}"

module.exports = WaveBouyService =

  getWaveBouys: (cb) ->
    logger.info "calling mongo for wave-bouy"
    WaveBouy.find {}, (err, waveBouy) -> cb err, waveBouy

  getWaveBouy: (id, cb) ->
    WaveBouy.findOne {_id: id}, (err, waveBouy) -> cb err, waveBouy

  createOrUpdateBouy: (wBouy, cb) ->
    WaveBouy.update {stn: wBouy.stn, time: wBouy.time},
      wBouy, {upsert: true}, (err, waveBouy) -> cb err, waveBouy

  createWaveBouy: (wBouy, cb) ->
    waveBouy = new WaveBouy(wBouy)
    waveBouy.save (err) -> cb err, waveBouy

  deleteWaveBouy: (id, cb) ->
    WaveBouy.findOneAndRemove {'_id': id}, (err, waveBouy) -> cb err, waveBouy

