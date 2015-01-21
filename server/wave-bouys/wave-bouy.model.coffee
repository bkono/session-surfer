mongoose = require 'mongoose'
Schema = mongoose.Schema

WaveBouy = new Schema
  stn:
    type: String
    index:
      unique: false
    required: true
  time: Date
  wvht: Number
  swh: Number
  swp: Number
  wwh: Number
  swd: String
  wwd: String
  steepness: String
  apd: Number
  mwd: Number

module.exports = mongoose.model('WaveBouy', WaveBouy)
