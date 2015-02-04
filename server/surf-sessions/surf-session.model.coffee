mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

SurfSession = new Schema
  startTime: Date
  endTime: Date
  ratings:
    wave: {type: Number, min: 0, max: 5}
    wind: {type: Number, min: 0, max: 5}
    overall: {type: Number, min: 0, max: 5}
    crowd: {type: Number, min: 0, max: 5}

module.exports = mongoose.model('SurfSession', SurfSession)
