_isBuilder = ->
  user = Meteor.user()
  (user and user.isAdmin) == true


_features = ->
  posts = Posts.find().fetch()
  isBuilder = _isBuilder()
  features = _.map(posts, (p, idx) -> {
    _id: p._id
    featureIdx: idx+1
    featureCount: _.size(posts)
    featureName: p.title
    cost: p.aggregateCost or 1
    benefit: p.aggregateBenefit or 1
    isBuilder: isBuilder
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
  Telescope.subsManager.subscribe("iq_releases")
)

Template.planning.helpers(
  _ready: ->
    Telescope.subsManager.ready()

  _heroData: -> Fixtures.getData("sectionHero", "Planning")

  _isPlanThere: -> IQ.Releases.find({state: IQ.Releases.STATE.PLANNING}).count() > 0

  _isPlanning: ->
    release = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
    if (release && release[IQ.Releases.STATE.PLANNING]) 
      release[IQ.Releases.STATE.PLANNING].start > new Date()  
    else
      false
    

  _isBuilding: -> IQ.Releases.find({state: IQ.Releases.STATE.BUILDING}).count() > 0

  _isBuilder: -> _isBuilder()

  _featureData: ->
    features: _features()

  _buildFormData: ->
    # FIXME: should choose the exact one that the user is looking at
    planningRelease = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
    data =
      releaseId: planningRelease._id
      userCount: 72
      builderCount: 18
      planning:
        features: _features()

  _cardData: ->
    features = _features()
    return {} if _.isEmpty(features)
    _.first(features)

  _cardsData: ->
    features = _features()
    console.log "features", features
    data =
      selected: 0
      pokerCards: features
)
