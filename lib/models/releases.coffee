@IQ or= {}

PhaseSchema = new SimpleSchema(
  start:
    type: Date
  features:
    type: [String]
    blackbox: true
  description:
    type: String
    max: 1000
    optional: true
)

IQ.Releases = new Mongo.Collection("iq_releases")
IQ.Releases.STATE =
  PLANNING: 'planning'
  BUILDING: 'building'
  LAUNCHED: 'launched'

IQ.Releases.attachSchema(new SimpleSchema(
  name:
    type: String
    max: 140
  createdAt:
    type: Date
  state:
    type: String
  planning:
    type: PhaseSchema
  build:
    type: PhaseSchema
    optional: true
  launch:
    type: PhaseSchema
    optional: true
))
