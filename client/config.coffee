Telescope.config.addCustomPrefix("iq_")

Telescope.modules.remove("mobileNav", "search")
Telescope.modules.remove("mobileNav", "submit_button")

#FIXME: fixes a bug in telescope
Template.layout.helpers(
  pageName: ->
    FlowRouter.watchPathChange()
    FlowRouter.current().route.name
)
