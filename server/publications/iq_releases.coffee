Meteor.publish("iq_releases", () ->
  IQ.Releases.find(
    # $or: [
    #   phase: IQ.Releases.STATE.BUILDING,
    #   phase: IQ.Releases.STATE.LAUNCHED
    # ]
  )
)
