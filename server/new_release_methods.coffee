@IQ or= {}

Meteor.methods(
  createRelease: (formData) ->
    #FIXME: filter the features with formData.numCandidates and cost/benefit scores
    featureCandidates = Posts.find({}, {fields: {name: 1, cost: 1, benefit: 1}}).fetch()
    featureIds = _.map(featureCandidates, (f) -> f._id)

    planning =
      start: formData.startTime
      features: featureIds
      description: formData.desc

    build =
      start: formData.startTime
      features: []
      description: ""

    release =
      name: formData.name
      createdAt: new Date(),
      state: "planning"
      planning: planning,
      build: build,
      launch: {}

    # FIXME: Exception while invoking method 'createRelease' Error: 0 must be an object

    IQ.Releases.insert(
      release
    )
)
