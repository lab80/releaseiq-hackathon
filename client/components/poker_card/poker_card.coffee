Template.pokerCard.onRendered(->
  @$(".js-cost-input").slider(min: 0, max: 5, value: @data.cost, tooltip: "hide")
  @$(".js-benefit-input").slider(min: 0, max: 5, value: @data.benefit, tooltip: "hide")
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
