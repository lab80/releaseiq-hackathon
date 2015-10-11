Template.featureItem.helpers(
  _featureBCRatio: -> (this.benefit / this.cost).toFixed(2)
)

Fixtures.addFixture("featureItem", ""
  Loading: {}
  Normal:
    featureName: "Feature 1"
    cost: 4
    benefit: 5
)
