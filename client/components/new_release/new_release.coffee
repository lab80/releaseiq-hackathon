Template.newRelease.onCreated(->
  _startPicker = new Pikaday({ field: $('#start-time')[0] });
  _endPicker = new Pikaday({ field: $('#end-time')[0] });
)

Template.newRelease.onRendered(->
  undefined
)

Template.newRelease.events(
  "submit #new-release-form": (event, template) ->
    event.preventDefault()
    formData =
      name: template.$("#release-name").val()
      desc: template.$("#description").val()
      startTime: template.$("#start-time").val()
      endTime: template.$("#end-time").val()
      numCandidates: template.$("#num-candidates").val()

    Meteor.call("createRelease", formData)
)

Fixtures.addFixture("newRelease", ""
  # Loading: {}
  Normal: {}
)
