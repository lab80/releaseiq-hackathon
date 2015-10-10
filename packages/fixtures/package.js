Package.describe({
  name: 'lab80:fixtures',
  version: '0.0.1',
  summary: 'Fixture gallery',
  debugOnly: true
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.0.2');
  api.use([
    'coffeescript',
    'underscore',
    'templating',
    'blaze',
    'jquery',
    'tracker',
    'reactive-var',
    'less',
    'kadira:flow-router',
    'kadira:blaze-layout',
    'practicalmeteor:underscore.string',
  ], 'client')

  // Library
  api.addFiles('lib/component_fixtures.coffee', 'client');

  // Component View & Route
  api.addFiles('component-view/component.html', 'client');
  api.addFiles('component-view/component.coffee', 'client');
  api.addFiles('component-view/component.less', 'client');
  api.addFiles('routes.coffee', 'client');
});
