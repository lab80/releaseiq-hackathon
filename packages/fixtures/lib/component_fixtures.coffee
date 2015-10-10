@Fixtures =
  _fixtures: []
  getFixtures: ->
    @_fixtures
  getFixture: (componentId) ->
    _.findWhere(@_fixtures, id: componentId)
  getData: (template, stateName) ->
    fixture = _.findWhere(@_fixtures, template: template)
    _.findWhere(fixture.states, name: stateName).data
  addFixture: (template, wrapperClasses, states) ->
    fixture =
      name: _s.humanize(template)
      id: _s.dasherize(template)
      template: template
      wrapperClasses: wrapperClasses
      states: _.map(_.pairs(states), (pair) ->
        [name, data] = pair
        {name: name, data: data}
      )
    @_fixtures.push(fixture)
