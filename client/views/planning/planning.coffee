_isBuilder = ->
  user = Meteor.user()
  (user and user.isAdmin) == true

_features = ->
  posts = Posts.find().fetch()
  isBuilder = _isBuilder()
  features = _.map(posts, (p, idx) -> {
    _id: p._id
    featureIdx: idx
    featureCount: _.size(posts)
    featureName: p.title
    cost: p.aggregateCost or 5
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
  @selectedIdx = new ReactiveVar(0)
  Telescope.subsManager.subscribe("postsList", _terms())
)
Template.planning.events(
  "click .dot circle": (event, template) ->
    newIndex = parseInt($(event.target).attr("data-idx"))
    Template.instance().selectedIdx.set(newIndex)
  "slid.bs.carousel": (event, template) ->
    newIndex = $(event.relatedTarget).index()
    Template.instance().selectedIdx.set(newIndex)
)
Template.planning.helpers(
  _releaseName: ->
    release = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
    release.name

  _featureData: ->
    data =
      selectedIdx: Template.instance().selectedIdx.get()
      features: _features()

  _cardsData: ->
    features = _features()
    data =
      selectedIdx: Template.instance().selectedIdx.get()
      pokerCards: features

  _countdownTime: ->
    release = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
    release.building.start
)

Template.planningWrapper.onCreated(->
  Telescope.subsManager.subscribe("iq_releases")
)

Template.planningWrapper.helpers(
  _ready: ->
    Telescope.subsManager.ready()

  _heroData: -> Fixtures.getData("sectionHero", "Planning")

  _isPlanThere: -> IQ.Releases.find({state: IQ.Releases.STATE.PLANNING}).count() > 0

  _isPlanning: ->
    # release = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
    release = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
    release?[IQ.Releases.STATE.PLANNING].start < new Date()

  _isBuilding: -> IQ.Releases.find({state: IQ.Releases.STATE.BUILDING}).count() > 0

  _isBuilder: -> _isBuilder()

  _buildReleaseFormData: ->
    planningRelease = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
    data =
      name: planningRelease.name
      releaseId: planningRelease._id
      userCount: 72
      builderCount: 18
      planning:
        features: _features()
)
