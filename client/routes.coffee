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
  action: -> BlazeLayout.render("planning", {})
)

FlowRouter.route("/releases",
  name: "releases"
  action: -> BlazeLayout.render("releases", {})
)
