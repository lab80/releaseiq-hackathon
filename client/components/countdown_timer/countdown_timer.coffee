Template.countdownTimer.onCreated(->
  @now = new ReactiveVar((new Date()).getTime())
  self = this
  @handle = Meteor.setInterval(->
    self.now.set((new Date()).getTime())
  , 1000)
)

Template.countdownTimer.onDestroyed(->
  Meteor.clearInterval(@handle)
)

Template.countdownTimer.helpers(
  _endingFormatted: ->
    diff = @endingAt.getTime() - Template.instance().now.get()
    moment.utc(diff).format("HH[h]:mm:ss")
)

Fixtures.addFixture("countdownTimer", "",
  Loading: {}
  Minutes:
    endingAt: moment().add(3, "minutes").add(37, "seconds").toDate()
  Hours:
    endingAt: moment().add(4, "hours").add(3, "minutes").toDate()
  Days:
    endingAt: moment().add(3, "days").add(2, "hours").toDate()
)
