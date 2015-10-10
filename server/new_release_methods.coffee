@IQ or= {}

Meteor.methods(
  createRelease: (formData) ->
    #FIXME: filter the features with formData.numCandidates and cost/benefit scores
    featureCandidates = Posts.find({}, {fields: {name: 1, cost: 1, benefit: 1}}).fetch()

    planning =
      start: formData.startTime
      features: featureCandidates
      description: formData.desc

    build =
      start: formData.startTime

    IQ.Releases.insert(
      name: formData.name
      createdAt: new Date(),
      state: "planning"
      planning: planning,
      build: build,
      launch: {}
    )
)
