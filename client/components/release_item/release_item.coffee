Template.releaseItem.helpers(
  _releaseDescription: -> this[this.state]?.description

  _releaseFeatures: ->
    posts = Posts.find({_id: {$in: this[this.state]?.features}}).fetch()
    features = _.map(posts, (p) ->
      featureName: p.title
      cost: p.aggregateCost
      benefit: p.aggregateBenefit
    )
    features

  _startDate: ->
    moment(this.building.start).format("ddd L")

  _endDate: ->
    moment(this.launched?.start).format("ddd L")
)

_randomFeatures = (n) ->
  _.map(_.range(n), (idx) ->
    {featureName: "feature#{idx}", cost: _.random(1, 5), benefit: _.random(1, 5)}
  )

Fixtures.addFixture("releaseItem", ""
  Loading: {}
  Building:
    name: "Building release"
    state: "building"
    building:
      description: "building this now"
      features: _randomFeatures(3)
  Launched:
    name: "Building release"
    state: "launched"
    launched:
      description: "launched this now"
      features: _randomFeatures(5)
)
