Template.launchReleaseForm.events(
  "submit #launch-release-form": (event, template) ->
    event.preventDefault()
    formData =
      releaseId: template.data.releaseId
      description: template.$("#description").val()

    Meteor.call("launchRelease", formData)
    FlowRouter.go("/backlog")
)
