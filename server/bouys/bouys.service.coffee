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
    logger.info "calling mongo"
    Bouy.find {}, (err, bouy) -> cb err, bouy

  getBouy: (id, cb) ->
    Bouy.findOne {_id: id}, (err, bouy) -> cb err, bouy

  createBouy: (bouy, cb) ->
    bouy = new Bouy(bouy)
    bouy.save (err) -> cb err, bouy

  firstOrCreateBouy: (bouy, cb) ->
    Bouy.update {stationId: bouy.stationId}, bouy, {upsert: true}, (err, bouy) -> cb err, bouy

  deleteBouy: (id, cb) ->
    Bouy.findOneAndRemove {'_id': id}, (err, bouy) -> cb err, bouy

