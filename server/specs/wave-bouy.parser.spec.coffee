config = require '../config/config'
global.eventServer = new (require('events')).EventEmitter
should = require('chai').should()
fs = require 'fs'
server = global.eventServer
WaveBouyParser = require('../wave-bouys/wave-bouys.parser').waveBouyParser

describe 'Parsing the wave buoy hourly data', ->
  parser = new WaveBouyParser({objectMode: true})

  it 'parses the sample file of two readings', (done) ->
    count = 0
    server.on 'waveBouy:reading', (buoy) ->
      count += 1
      # buoy.time.getYear().should.equal(2015)
      done() if count is 3
    fs.createReadStream('./server/specs/support/wave-buoy-sample.txt',
      {encoding: 'utf8'}).pipe(new WaveBouyParser({objectMode: true}))

  describe '#parseWaveBuoy', ->
    headers = [ 'stn', 'yy', 'mo',
      'dd', 'hh', 'mm', 'wvht', 'swh', 'swp', 'wwh', 'wwp', 'swd',
      'wwd', 'steepness', 'apd', 'mwd']
    buoyText = '52202 2015 02 07 22 55  2.1  0.8 11.8  1.9  7.7 NNE  NE      STEEP  6.1  50'
    it 'parses wave buoy data given headers',  ->
      buoyText = buoyText.split(/\s+/)
      parser = new WaveBouyParser({objectMode: true})
      buoy = parser.parseWaveBuoy(buoyText, headers)
      buoy.stn.should.equal('52202')
      buoy.time.should.eql(new Date(2015,1,7,22,55,0))
      buoy.time.getHours().should.equal(22)
      buoy.time.getMonth().should.equal(1)
      buoy.time.toString().should.contain('Feb')
      buoy.steepness.should.equal('STEEP')
      buoy.wvht.should.equal('2.1')
      buoy.swh.should.equal('0.8')
      buoy.swp.should.equal('11.8')
      buoy.wwh.should.equal('1.9')
      buoy.wwp.should.equal('7.7')
      buoy.swd.should.equal('NNE')
      buoy.wwd.should.equal('NE')
      buoy.apd.should.equal('6.1')
      buoy.mwd.should.equal('50')

    it 'converts MM to -99 if the field is a number', ->
      buoyTextMM = 'LJPC1 2015 02 07 22 24  0.8  0.8  5.0  0.0   MM  MM  MM        N/A   MM -99'
      buoyTextMM = buoyTextMM.split(/\s+/)
      parser = new WaveBouyParser({objectMode: true})
      buoy = parser.parseWaveBuoy(buoyTextMM, headers)
      buoy.apd.should.equal('-99')
  #
  # it 'parses the date time correctly to hour', (done) ->

  describe 'parsing wave buoy headers', ->
    headerText = "#STN  #YY  MM DD hh mm WVHT  SwH  SwP  WWH  WWP SwD WWD  STEEPNESS  APD MWD"
    it "parses #STN  #YY  MM DD hh mm WVHT\
      SwH  SwP  WWH  WWP SwD WWD  STEEPNESS  APD MWD\
      into stn yy  mo dd hh mm wvht  swh  swp  wwh\
      wwp swd wwd  steepness  apd mwd", ->
      headers = parser.parseHeaderRow(headerText)
      headers.length.should.equal(16)
      headers.should.include('stn')
      headers.should.include('yy')
      headers.should.include('mo')
      headers.should.include('dd')
      headers.should.include('hh')
      headers.should.include('mm')
      headers.should.include('wvht')
      headers.should.include('swh')
      headers.should.include('swp')
      headers.should.include('wwh')
      headers.should.include('wwp')
      headers.should.include('swd')
      headers.should.include('wwd')
      headers.should.include('steepness')
      headers.should.include('apd')
      headers.should.include('mwd')

