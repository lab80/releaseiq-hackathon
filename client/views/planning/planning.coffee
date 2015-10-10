_features = ->
  posts = Posts.find().fetch()
  features = _.map(posts, (p) -> {
    _id: p._id
    featureName: p.title
    cost: p.aggregateCost or 1
    benefit: p.aggregateBenefit or 1
    isBuilder: true
  })

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
  _ready: ->
    Telescope.subsManager.ready()

  _heroData: -> Fixtures.getData("sectionHero", "Normal")

  _featureData: ->
    #Fixtures.getData("featureGrid", "Normal")
    features: _features()

  _cardData: ->
    #Fixtures.getData("pokerCard", "User")
    features = _features()
    return {} if _.isEmpty(features)
    _.first(features)

  _cardsData: ->
    features = _features()
    console.log "features", features
    data =
      selected: 0
      pokerCards: features
    #Fixtures.getData("pokerCards", "UserLoaded")
)
