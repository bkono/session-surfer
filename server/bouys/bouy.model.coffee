mongoose = require 'mongoose'
Schema = mongoose.Schema

Bouy = new Schema
  stationId:
    type: String
    index:
      unique: true
    required: true
  owner: String
  ttype: String
  hull: String
  name: String
  payload: String
  location:
    type: 
      type: String
      required: true,
      enum: ['Point', 'LineString', 'Polygon'],
      default: 'Point'
    coordinates: {type: [Number], index: '2dsphere'}
  timezone: String
  forecast: String
  note: String

module.exports = mongoose.model('Bouy', Bouy)
