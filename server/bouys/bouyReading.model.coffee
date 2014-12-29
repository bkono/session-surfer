mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

BouyReading = new Schema
  stationId: 
    type: String
    index: 
      unique: false
    required: true
  createdAt: 
    type: Date
    default: Date.now
  recordedAt: 
    type: Date
    default: Date.now
  htmlContent: 
    type: String

module.exports = mongoose.model('BouyReading', BouyReading)
