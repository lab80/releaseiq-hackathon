@IQ or= {}

Meteor.methods(
  launchRelease: (formData) ->
    #FIXME:!@!@
    build = IQ.Releases.findOne({state: IQ.Releases.STATE.BUILDING})
    launched =
      start: new Date()
      description: formData?.description or ""
      features: _.clone(build.building.features)
    return IQ.Releases.update(
      {state: IQ.Releases.STATE.BUILDING}
      {$set:
        {state: IQ.Releases.STATE.LAUNCHED, launched: launched}
      }
      {multi: true}
    )

  createRelease: (formData) ->
    #FIXME: filter the features with formData.numCandidates and cost/benefit scores
    featureCandidates = Posts.find({}, {fields: {name: 1, cost: 1, benefit: 1}}).fetch()
    featureIds = _.map(featureCandidates, (f) -> f._id)

    planning =
      start: formData.startTime
      features: featureIds
      description: formData.desc

    building =
      start: formData.endTime
      features: []
      description: ""

    state = if building.start < new Date() then IQ.Releases.STATE.BUILDING else IQ.Releases.STATE.PLANNING

    release =
      name: formData.name
      createdAt: new Date(),
      state: state
      planning: planning,
      building: building

    console.log "release", release

    return IQ.Releases.insert(
      release
    )

  startBuilding: (formData) ->
    buildPhase =
      start: formData.startTime,
      features: formData.features,
      description: formData.desc

    return IQ.Releases.update(formData.releaseId,
      $set:
        state: IQ.Releases.STATE.BUILDING
        building: buildPhase
    )
)
