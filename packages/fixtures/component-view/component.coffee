Template.componentList.helpers(
  components: -> _.values(Fixtures.getFixtures())
)

Template.component.helpers(
  stringify: (data) -> JSON.stringify(data, null, ' ')
)
