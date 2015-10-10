Telescope.config.addCustomPrefix("iq_")

#FIXME: fixes a bug in telescope
Template.layout.helpers(
  pageName: ->
    FlowRouter.watchPathChange()
    FlowRouter.current().route.name
)
