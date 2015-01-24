logger = require '../config/logger'
http = require 'http'
changeCase = require 'change-case'
lo = require 'lodash'
mongoose = require 'mongoose'
BouyModel = require './bouy.model'
Bouy = mongoose.model 'Bouy'
BouySync = require './bouy-sync.service'
events = global.eventServer

events.on 'bouy:available', (bouy) ->
  BouyService.firstOrCreateBouy  bouy, (error, station) ->
    logger.error error if error

module.exports = BouyService =

  getBouys: (cb) ->
    Bouy.find {}, (err, bouy) -> cb err, bouy

  getBouy: (id, cb) ->
    Bouy.findOne {stationId: changeCase.lower(id) }, (err, bouy) ->
      cb err, bouy

  createBouy: (bouy, cb) ->
    newBouy = new Bouy(bouy)
    newBouy.save (err) -> cb err, newBouy

  firstOrCreateBouy: (bouy, cb) ->
    Bouy.update {stationId: bouy.stationId},
      bouy, {upsert: true}, (err, bouy) -> cb err, bouy

  deleteBouy: (id, cb) ->
    Bouy.findOneAndRemove {'_id': id}, (err, bouy) -> cb err, bouy

