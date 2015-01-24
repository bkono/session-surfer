changeCase = require 'change-case'
lo = require 'lodash'
request = require 'request'
CronJob = require('cron').CronJob
server = global.eventServer
Transform = require('stream').Transform
logger  = require '../config/logger'

exports.run = ->
  currentHour = () -> new Date().getUTCHours()

  checkHour = (hour = null)->
      hour?= currentHour()
      server.emit 'waveBouy:checkHour', hour

  new CronJob(
    cronTime: '* */10 * * * *'
    onTick: checkHour
    start: true,
    timeZone: "UTC"
    )
  # grab the last hour
  checkHour( currentHour() - 1 )

server.on 'waveBouy:checkHour', (hour) ->
  hour = hour + 24 if hour < 0
  hour = "0#{hour}" if hour < 10
  reqUrl = "http://www.ndbc.noaa.gov/data/hourly2/hour_#{hour}.spec"
  logger.info "requesting wave url: [ #{reqUrl} ]"
  parser = new WaveBouyFileParser({objectMode: true})
  request(reqUrl).pipe(parser)

class WaveBouyFileParser extends Transform
  constructor: (options) ->
    super(options)
    @nextRows = ''
    @headers = null

  _transform: (data, encoding, next) ->
    @nextRows += data.toString()
    rows = @nextRows.split(/\r?\n|\r/g)
    if ( rows.length > 1 )
      #store off a partial or the empty line at the end of the file
      @nextRows = rows.pop()
      @headers = @parseHeaderRow(rows.shift()) unless @headers?
      rows.shift() if rows[0].indexOf("-Sub") > -1
      rows.map (waveBouy) =>
        waveBouyObj = @parseWaveBouy(waveBouy.split(/\s+/), @headers)
        server.emit 'waveBouy:reading', waveBouyObj unless waveBouyObj is null
    next()

  parseHeaderRow: (headerRow) ->
    headerRow.split(/\s+/).map (header) ->
      header = 'mo' if header == "MM"
      changeCase.camelCase(header.replace('#', '')) if header?

  parseWaveBouy:  (waveBouy, @headers) ->
    return null unless waveBouy.length == @headers.length
    waveBouyClean = lo.map(waveBouy, (val) -> val.replace('MM', '-99'))
    waveBouyObject = lo.object(lo.zip(@headers, waveBouyClean))
    timeKeys = ['yy', 'mo', 'dd', 'hh', 'mm']
    [yr, mo, d, hr, mi, ms] = lo.values(
      lo.pick( waveBouyObject, timeKeys)).concat([0,0])
    waveBouyObject['time'] = new Date(yr, mo, d, hr, mi, ms)
    lo.omit(waveBouyObject,timeKeys)

