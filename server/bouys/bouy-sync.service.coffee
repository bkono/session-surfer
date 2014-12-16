http = require 'http'
changeCase = require 'change-case'
lo = require 'lodash'
Transform = require('stream').Transform
request = require 'request'

exports.run = ->
  request('http://www.ndbc.noaa.gov/data/stations/station_table.txt').pipe(parser)

exports.parser = parser = new Transform({objectMode: true})
nextRows = ''
headers = null
server = global.eventServer

parser._transform = (data, encoding, done) ->
  nextRows += data.toString()
  rows = nextRows.split(/\r?\n|\r/g)
  if ( rows.length > 1 )
    nextRows = rows.pop() #store off a partial or the empty line at the end of the file
    headers = parseHeaderRow(rows.shift()) unless headers?
    rows.shift() if rows[0] == '#'
    rows.map (station) =>
      stationObj = parseStation(station.split('|'), headers)
      server.emit 'bouy:available', stationObj unless stationObj is null
      
  done()

parseStation = (station, headers) ->
  return null unless station.length == headers.length
  stationObject = lo.object(lo.zip(headers, station))
  stationObject['location'] = parseLocation(stationObject['location'])
  stationObject

parseHeaderRow = (headerRow) ->
  headerRow.split('|').map (header) ->
    changeCase.camelCase(header.replace('#', '')) if header?

parseLocation = (location) ->
  parse = location.match(/(\d+\.\d+)\s+(\w)\s+(\d+\.\d+)\s+(\w)/)
  latlong = "#{parse[2]}#{parse[1]}, #{parse[4]}#{parse[3]}"
  coords = latlong.replace(/[SW]/g, '-').replace(/[NE]/g,'').split(',').map (coord) -> (parseFloat(coord))
  {type: 'Point', coordinates: coords.reverse()} #geojson is long, lat
