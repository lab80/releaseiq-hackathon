Template.releases.onCreated(->
  Telescope.subsManager.subscribe("iq_releases")
)

_buildingReleases = -> IQ.Releases.find({state: IQ.Releases.STATE.BUILDING})

_launchedReleases = -> IQ.Releases.find({state: IQ.Releases.STATE.LAUNCHED})

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
