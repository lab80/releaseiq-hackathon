Template.releases.onCreated(->
  Telescope.subsManager.subscribe("iq_releases")
)

Template.releases.onRendered(->
  console.log("release rendered")
)

Template.releases.helpers(
  _heroData: -> Fixtures.getData("sectionHero", "Releases")

  _noPlanning: -> IQ.Releases.find({state: IQ.Releases.STATE.PLANNING}).count() == 0

  _buildingReleases: -> IQ.Releases.find({state: IQ.Releases.STATE.BUILDING})

  _launchedReleases: -> IQ.Releases.find({state: IQ.Releases.STATE.LAUNCHED})

  _launchReleaseFormData: ->
    buildingRelease = IQ.Releases.findOne({state: IQ.Releases.STATE.BUILDING})
    data =
      releaseId: buildingRelease._id

  _isBuilder: ->
    user = Meteor.user()
    (user and user.isAdmin) == true
)
