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

Template.pokerCards.events(
  "click .js-left": (event, template) -> template.$(".js-carousel").carousel("prev")
  "click .js-right": (event, template) -> template.$(".js-carousel").carousel("next")
)

Template.pokerCards.helpers(
  _isSelected: (idx) ->
    this.selected == idx
)

Fixtures.addFixture("pokerCard", ""
  Loading: {}
  User:
    featureName: 'Feature name'
    cost: 1
    benefit: 4
    isBuilder: false
  Builder:
    featureName: 'Feature name'
    cost: 4
    benefit: 3
    isBuilder: true
)

_cards = (isBuilder) -> _.map(_.range(5), (idx) ->
  featureName: "Feature #{idx} (#{_.random(0, 5)}, #{_.random(0, 5)})"
  cost: _.random(0, 5)
  benefit: _.random(0, 5)
  isBuilder: isBuilder
)

Fixtures.addFixture("pokerCards", ""
  UserLoaded:
    selected: 3
    pokerCards: _cards(false)
  BuilderLoaded:
    selected: 3
    pokerCards: _cards(true)
)
