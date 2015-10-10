Template.buildReleaseForm.onRendered(->
  _startPicker = new Pikaday({ field: $('#start-time')[0] });
  _endPicker = new Pikaday({ field: $('#end-time')[0] });
)

Template.buildReleaseForm.helpers(
  _duration: -> "24 hours" #FIXME

  features: -> this.features
  
  releaseName: -> "What is release name" #FIXME
)

Template.buildReleaseForm.events(
  "submit #build-release-form": (event, template) ->
    event.preventDefault()

    # FIXME: should rather retrieve the release that the builder is looking at.
    # get it from the parent template
    planningRelease = IQ.Releases.findOne({
      state: IQ.Releases.STATE.PLANNING
    })

    selectedFeatures = $("input:checkbox[name=type]:checked")

    debugger

    formData =
      releaseId: planningRelease._id
      desc: template.$("#description").val()
      startTime: new Date(template.$("#start-time").val())
      endTime: new Date(template.$("#end-time").val())
      numCandidates: template.$("#num-candidates").val()

    Meteor.call("updateRelease", formData)
)

Template.buildFeatureRow.helpers(
  _featureBCRatio: -> this.benefit / this.cost
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
