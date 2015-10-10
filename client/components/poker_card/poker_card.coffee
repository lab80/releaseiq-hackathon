Template.pokerCard.helpers(
  _ready: ->
    console.log "ready", Telescope.subsManager.ready()
    Telescope.subsManager.ready()
)

_setValue = ($what, value) ->
  $what.slider(min: 0, max: 5, value: value, tooltip: "hide")

Template.pokerCard.onRendered(->
  self = this
  Meteor.setTimeout(->
    _setValue(self.$(".js-cost-input"), self.data.cost or 1)
    _setValue(self.$(".js-benefit-input"), self.data.benefit or 1)
  , 100)
  # Meteor.defer(->
  #   self.autorun(->
  #     data = Template.currentData()
  #     _setValue(self.$(".js-cost-input"), data.cost)
  #     _setValue(self.$(".js-benefit-input"), data.benefit)
  #   )
  #)
)

Fixtures.addFixture("pokerCard", ""
  Loading: {}
  User:
    featureName: "Feature name"
    isBuilder: false
    benefit: 1
  Builder:
    featureName: "Feature name"
    isBuilder: true
    cost: 1
    benefit: 1
)
