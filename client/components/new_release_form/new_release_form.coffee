# Template.newRelease.onRendered(->
#   _startPicker = new Pikaday({ field: $('#start-time')[0] });
#   _endPicker = new Pikaday({ field: $('#end-time')[0] });
# )

Template.newRelease.events(
  "submit #new-release-form": (event, template) ->
    event.preventDefault()
    formData =
      name: template.$("#release-name").val()
      desc: template.$("#description").val()
      startTime: moment().subtract(1, "min").toDate()
      endTime: moment().add(1, "day").toDate()
      numCandidates: template.$("#num-candidates").val()

    Meteor.call("createRelease", formData)
)

Fixtures.addFixture("newRelease", ""
  # Loading: {}
  Normal: {}
)
