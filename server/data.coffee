@DevelopmentFixtures =
  fullSetup: ->
    @clearAll()
    @addFeatures()
  clearAll: ->
    Posts.remove({})
  addFeatures: ->
    features = JSON.parse(Assets.getText("fixtures/feature_requests.json"))
    console.log "Adding #{_.size(features)} features"
    _.each(features, (feature) ->
      postedAt = moment(feature.date.trim(), "YYYYMMDD").toDate()
      user = _.sample(Users.find().fetch())
      post =
        postedAt: postedAt
        body: feature.description.trim()
        title:  feature.name.trim()
        userId: user?._id
      Posts.submit(post)
    )

Meteor.startup(->
  if Posts.find().count() == 0
    DevelopmentFixtures.addFeatures()
)
