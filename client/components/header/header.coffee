Template.header.helpers(
  _headerClass: -> "page-header"
  _getActive: (what) ->
    FlowRouter.watchPathChange()
    "active" if what is FlowRouter.current().route.name
)

Fixtures.addFixture("iq_header", ""
  Loading: {}
)
