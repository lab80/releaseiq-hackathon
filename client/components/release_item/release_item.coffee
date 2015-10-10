Template.releaseItem.helpers(
  _releaseDescription: -> this[this.state]?.description

  _releaseFeatures: ->
    console.log "features", this
    this[this.state]?.features
)

Template.featureItem.helpers(
  _featureBCRatio: -> this.benefit / this.cost
)


Fixtures.addFixture("featureItem", ""
  Loading: {}
  Normal:
    featureName: "Feature 1"
    cost: 4
    benefit: 5
)

_randomFeatures = (n) ->
  _.map(_.range(n), (idx) ->
    {featureName: "feature#{idx}", cost: _.random(1, 5), benefit: _.random(1, 5)}
  )

Fixtures.addFixture("releaseItem", ""
  Loading: {}
  Building:
    name: "Building release"
    state: "build"
    build:
      description: "building this now"
      features: _randomFeatures(3)
  Launched:
    name: "Building release"
    state: "launch"
    launch:
      description: "launched this now"
      features: _randomFeatures(5)
)
