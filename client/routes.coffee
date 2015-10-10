FlowRouter.route("/",
  name: "home"
  action: -> BlazeLayout.render("home", {})
)

FlowRouter.route("/backlog",
  name: "backlog"
  action: -> BlazeLayout.render("layout", {main: "backlog_posts_list"})
)

FlowRouter.route("/plan",
  name: "plan"
  action: -> BlazeLayout.render("plan", {})
)

FlowRouter.route("/releases",
  name: "releases"
  action: -> BlazeLayout.render("releases", {})
)
