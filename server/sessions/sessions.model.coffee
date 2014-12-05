mongoose = require 'mongoose'
Schema = mongoose.Schema

Session = new Schema(
  startTime:
    type: Date
  endTime:
    type: Date
  waveHeight:
    type: Number
  crowd:
    type: Number
  wind: 
    type: Number
)

module.exports = mongoose.model('Session', Session)
