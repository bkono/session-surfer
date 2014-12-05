mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

SurfSession = new Schema
  startTime: Date
  endTime: Date
  waveHeight: Number
  crowd: Number
  wind: Number

module.exports = mongoose.model('SurfSession', SurfSession)
