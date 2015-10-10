FlowRouter.route("/component",
  name: 'componentList'
  action: -> BlazeLayout.render('componentList')
)

FlowRouter.route("/component/:componentId",
  name: 'component'
  action: (params) ->
    fixture = Fixtures.getFixture(params.componentId)
    BlazeLayout.render('component', fixture)
)
