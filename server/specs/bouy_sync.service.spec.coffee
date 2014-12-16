config = require '../config/config'
global.eventServer = new (require('events')).EventEmitter
should = require('chai').should()
fs = require 'fs'
server = global.eventServer
parser = require('../bouys/bouy-sync.service').parser

describe 'Parsing the bouy station table text', ->
  it 'parses the sample file of two stations', (done) ->
    count = 0
    server.on 'bouy:available', (bouy) ->
      count += 1
      ['00922','00923'].should.include(bouy.stationId)
      done() if count is 2
    fs.createReadStream('./server/specs/support/station_sample.txt', {encoding: 'utf8'}).pipe(parser)
