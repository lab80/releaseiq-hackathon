_features = ->
  posts = Posts.find().fetch()
  features = _.map(posts, (p) -> {featureName: p.title, cost: p.upvotes, benefit: p.commentCount})

_terms = ->
  terms = _.clone(FlowRouter.current().queryParams)
  terms.enableCache = true
  if Meteor.userId()
    terms.userId = Meteor.userId()
  if !terms.view
    terms.view = Settings.get('defaultView', 'top')


Template.planning.onCreated(->
  Telescope.subsManager.subscribe("postsList", _terms())
)

Template.planning.helpers(
  # _arguments: ->
  #   FlowRouter.watchPathChange()
  #   {terms: _terms()}

  _featureData: ->
    #Fixtures.getData("featureGrid", "Normal")
    features: _features()

  _cardData: ->
    #Fixtures.getData("pokerCard", "User")
    features = _features()
    return {} if _.isEmpty(features)
    _.first(features)
)
