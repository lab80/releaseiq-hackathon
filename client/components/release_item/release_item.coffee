Template.releaseItem.helpers(
  _releaseDescription: -> this[this.state]?.description

  _releaseFeatures: ->
    console.log "features", this
    this[this.state]?.features
)

Template.featureItem.helpers(
  _featureBCRatio: -> this.benefit / this.cost
)
