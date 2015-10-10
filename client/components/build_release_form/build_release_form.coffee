Template.buildReleaseForm.helpers(
  _duration: -> "24 hours" #FIXME
)

_features = (n) ->
  _.map(_.range(n), (idx) ->
    title: "Long long #{idx}"
    cost: _.random(0, 5)
    benefit: _.random(0, 5)
  )

Fixtures.addFixture("buildReleaseForm", ""
  Loading: {}
  Normal:
    userCount: 72
    builderCount: 18
    name: "Release name"
    planning:
      start: new Date()
      features: _features(3)
    build:
      start: new Date()
)
