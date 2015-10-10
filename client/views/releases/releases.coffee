Template.releases.onCreated(->
  Telescope.subsManager.subscribe("iq_releases")
)

Template.releases.onRendered(->
  console.log("release rendered")
)

Template.releases.helpers(
  _noPlanning: -> IQ.Releases.find({state: IQ.Releases.STATE.PLANNING}).count() == 0

  _buildingReleases: -> IQ.Releases.find({state: IQ.Releases.STATE.BUILDING})

  _launchedReleases: -> IQ.Releases.find({state: IQ.Releases.STATE.LAUNCHED})
)
