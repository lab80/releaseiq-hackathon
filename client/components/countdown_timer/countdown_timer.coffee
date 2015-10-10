Template.countdownTimer.helpers(
  _endingFormatted: ->
    moment(@endingAt).fromNow()
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
