Template.releases.onCreated(->
  Telescope.subsManager.subscribe("iq_releases")
)

Template.releases.onRendered(->
  console.log("release rendered")
)

Template.releases.helpers(
  releases: () ->
    IQ.Releases.find()
)
