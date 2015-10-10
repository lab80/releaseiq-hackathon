@IQ or= {}

Meteor.methods(
  launchRelease: ->
    return IQ.Releases.update({state: IQ.Releases.STATE.BUILDING}, {$set: {state: IQ.Releases.STATE.LAUNCHED}})
)
