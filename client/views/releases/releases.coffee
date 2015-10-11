_terms = ->
  terms = _.clone(FlowRouter.current().queryParams)
  terms.enableCache = true
  if Meteor.userId()
    terms.userId = Meteor.userId()
  if !terms.view
    terms.view = Settings.get('defaultView', 'top')

Template.releases.onCreated(->
  Telescope.subsManager.subscribe("iq_releases")
  Telescope.subsManager.subscribe("postsList", _terms())
)

_buildingReleases = -> IQ.Releases.find({state: IQ.Releases.STATE.BUILDING}, {sort: {"building.start": -1}})

_launchedReleases = -> IQ.Releases.find({state: IQ.Releases.STATE.LAUNCHED}, {sort: {"launched.start": -1}})

Template.releases.helpers(
  _noPlanning: -> IQ.Releases.find({state: IQ.Releases.STATE.PLANNING}).count() == 0

  _buildingReleases: _buildingReleases

  _launchedReleases: _launchedReleases

  _pageTitleCaption: ->
    buildingCount = _buildingReleases().count()
    launchedCount = _launchedReleases().count()
    "#{buildingCount + launchedCount} Total / #{buildingCount} in Progress"

  _launchReleaseFormData: ->
    buildingRelease = IQ.Releases.findOne({state: IQ.Releases.STATE.BUILDING})
    data =
      releaseId: buildingRelease._id
      name: buildingRelease.name

  _isBuilder: ->
    user = Meteor.user()
    (user and user.isAdmin) == true
)
