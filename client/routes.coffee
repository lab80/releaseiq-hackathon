FlowRouter.route("/",
  name: "home"
  action: -> BlazeLayout.render("home", {})
)

FlowRouter.route("/backlog",
  name: "backlog"
  action: -> BlazeLayout.render("layout", {main: "backlog_posts_list"})
)

FlowRouter.route("/planning",
  name: "planning"
  action: -> BlazeLayout.render("layout", {main: "planningWrapper"})
)

FlowRouter.route("/releases",
  name: "releases"
  action: -> BlazeLayout.render("layout", {main: "releases"})
)

# FIXME: put me inside /planning
FlowRouter.route("/releases/new",
  name: "releases"
  action: -> BlazeLayout.render("layout", {main: "newRelease"})
)
