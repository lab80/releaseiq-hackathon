Template.buildReleaseForm.onRendered(->
  _startPicker = new Pikaday({ field: $('#start-time')[0] })
  _endPicker = new Pikaday({ field: $('#end-time')[0] })
)

Template.buildReleaseForm.helpers(
  _duration: -> "24 hours" #FIXME
)

Template.buildReleaseForm.events(
  "submit #build-release-form": (event, template) ->
    event.preventDefault()

    selectedFeatures = $("input[type=checkbox]:checked")
    featureIds = _.map(selectedFeatures, (f) -> $(f).attr("id"))

    formData =
      releaseId: template.data.releaseId
      desc: template.$("#description").val()
      startTime: new Date(template.$("#start-time").val())
      endTime: new Date(template.$("#end-time").val())
      numCandidates: template.$("#num-candidates").val()
      features: featureIds

    Meteor.call("startBuilding", formData)
)

Template.buildFeatureRow.helpers(
  _featureBCRatio: -> (this.benefit / this.cost).toFixed(2)
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
    releaseId: "xxx"
    userCount: 72
    builderCount: 18
    name: "Release name"
    planning:
      features: _features(3)
      start: new Date()
    build:
      start: new Date()
)
