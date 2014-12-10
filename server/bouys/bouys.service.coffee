logger = require '../config/logger'
http = require 'http'
changeCase = require 'change-case'
lo = require 'lodash'
mongoose = require 'mongoose'
Bouy = require './bouy.model'
BouySync = require './bouy-sync.service'
events = global.eventServer

events.on 'bouy:available', (bouy) ->
  BouyService.firstOrCreateBouy  bouy, (error, station) ->
    console.log error if error
    console.log station if station

module.exports = BouyService =

  getBouys: (cb) ->
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


