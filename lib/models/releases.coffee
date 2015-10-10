@IQ or= {}

PhaseSchema = new SimpleSchema(
  start:
    type: Date
  features:
    type: [Object]
    blackbox: true
  announcement:
    type: String
    max: 1000
)

IQ.Releases = new Mongo.Collection("iq_releases")
IQ.Releases.STATE =
  ANNOUNCED: 'announced'
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
  launch:
    type: PhaseSchema
))

# Meteor.startup(-> addJob())
