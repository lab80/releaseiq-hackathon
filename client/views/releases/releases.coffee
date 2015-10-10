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

Template.releaseItem.helpers(
  releaseDescription: () ->
    phase = this[this.state]
    phase.description

  releaseFeatures: () ->
    phase = this[this.state]
    phase.features
)

Template.featureItem.helpers(
  featureBCRatio: () ->
    this.benefit / this.cost
)