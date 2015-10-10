Meteor.publish("iq_releases", () ->
  IQ.Releases.find()
)
