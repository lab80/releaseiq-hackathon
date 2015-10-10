_isBuilder = ->
  user = Meteor.user()
  (user and user.isAdmin) == true

Template.nextEvent.onCreated(->
  Telescope.subsManager.subscribe("iq_releases")
)

_isPlanThere = ->
  IQ.Releases.find({state: IQ.Releases.STATE.PLANNING}).count() > 0

_isPlanning = ->
  release = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
  release[IQ.Releases.STATE.PLANNING].start < new Date()

_isBuilding = -> IQ.Releases.find({state: IQ.Releases.STATE.BUILDING}).count() > 0

_dateLeft = ->
  release = IQ.Releases.findOne({state: IQ.Releases.STATE.PLANNING})
  now = moment(new Date())
  start = moment(release[IQ.Releases.STATE.PLANNING].start)
  moment.duration(now.diff(start)).humanize()

Template.nextEvent.helpers(
  _isPlanNotThere: -> _isPlanThere()

  _isPlanNotStarted: -> _isPlanThere() and not _isPlanning()

  _isPlanning: -> _isPlanning()

  _isBuilding: -> _isBuilding()

  _isBuilder: -> _isBuilder()

  _dateLeft: -> _dateLeft()
)

Fixtures.addFixture("nextEvent", ""
  Loading: {}
  NoPlanningUser:
    isPlanNotThere: true
    isBuilder: false
  NoPlanningBuilder:
    isPlanNotThere: true
    isBuilder: true
  WaitPlanningUser:
    isPlanNotStarted: true
    isBuilder: false
  WaitPlanningBuilder:
    isPlanNotStarted: true
    isBuilder: true
  PlanningUser:
    isPlanning: true
    isBuilder: false
  PlanningBuilder:
    isPlanning: true
    isBuilder: true
  BuildingUser:
    isBuilding: true
    isBuilder: false
  BuildingBuilder:
    isBuilding: true
    isBuilder: true
)
