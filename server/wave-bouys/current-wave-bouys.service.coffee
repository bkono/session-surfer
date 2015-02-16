changeCase = require 'change-case'
lo = require 'lodash'
logger  = require '../config/logger'
{EventEmitter} = require 'events'
server = global.eventServer

BouyService = require '../bouys/bouys.service'

module.exports = class CurrentWaveBouysService extends EventEmitter
  constructor: ->
    @currentReadings = {}
    server.on 'waveBouy:reading', (bouy) =>
      logger.debug "recieved bouy reading [ #{JSON.stringify(bouy)} ]"
      @addIfNewReading(bouy)

  isNewReading: (bouy) ->
    currentBouyReading = @currentReadings[bouy.stn] ||  {}
    {time: currentTime, stn: currentStn} = currentBouyReading
    {time: newTime, stn: newStn} = bouy
    not (currentStn? and (currentTime >= newTime) )

  getLocation: (bouy) ->
    return bouy.location if bouy.location?
    [error, station] = BouyService.getBouy(bouy.stn, (err, stn) -> [err, stn])
    if error?
      logger.error "Unable to find bouy info for: #{bouy.stn} [ #{err} ]"
      []
    else
      (station? && station.location) || []

  currentLocation: (bouy) ->
    @currentReadings[bouy.stn]? && @currentReadings[bouy.stn].location

  addIfNewReading: (bouy) ->
    return unless @isNewReading(bouy)
    bouy.location = @currentLocation(bouy) || @getLocation(bouy)
    @currentReadings[bouy.stn] = bouy
    @emit 'waveBouy:newReading', bouy
    logger.debug "received new wave data: [ #{JSON.stringify(bouy)} ]"
