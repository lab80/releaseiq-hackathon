# _getPosts = ->
#   Template.currentData().features
#   # posts = Posts.find({}, {fields: {name: 1, cost: 1, benefit: 1}}).fetch()
#   # _.each(posts, (p) ->
#   #   p.cost = _.random(0, 100)
#   #   p.benefit = _.random(0, 100)
#   # )
#   # posts

# Template.featureGrid.onRendered(->
#   self = this
#   # Set up the chart once
#   posts = _getPosts()
#   $chart = self.$('.js-feature-grid')
#   $chart.empty()

#   mx = [20, 20]
#   my = [20, 20]
#   width = $chart.width() - mx[0] - mx[1]
#   height = $chart.height() - my[0] - my[1]

#   xValue = (p) -> p.cost
#   xScale = d3.scale.linear()
#     .domain([d3.min(posts, xValue), d3.max(posts, xValue)])
#     .range([0, width])

#   yValue = (p) -> p.benefit
#   yScale = d3.scale.linear()
#     .domain([d3.min(posts, yValue), d3.max(posts, yValue)])
#     .range([0, height])

#   console.log "posts", posts
#   console.log "xScale", [d3.min(posts, xValue), d3.max(posts, xValue)], width
#   console.log "yScale", [d3.min(posts, yValue), d3.max(posts, yValue)], height

#   chart = d3.select($chart.get(0))
#   canvas = chart.append("svg")
#     .attr("width", $chart.width())
#     .attr("height", $chart.height())

#   canvas = canvas
#     .append('g')
#     .attr('transform', "translate(#{mx[0]}, #{my[0]})")

#   # canvas.selectAll(".dot")
#   #   .data(posts)
#   # .enter().append("circle")
#   #   .attr("class", "dot")
#   #   .attr("r", 3.5)
#   #   .attr("cx", (d) -> xScale(xValue(d)))
#   #   .attr("cy", (d) -> yScale(yValue(d)))

#   @autorun(->
#     # Re-render the chart reactively
#     foo = Session.get("foo")
#     posts = _getPosts()

#     xScale = d3.scale.linear()
#       .domain([d3.min(posts, xValue), d3.max(posts, xValue)])
#       .range([0, width])

#     yScale = d3.scale.linear()
#       .domain([d3.min(posts, yValue), d3.max(posts, yValue)])
#       .range([0, height])

#     # console.log "posts", posts
#     # console.log "xScale", [d3.min(posts, xValue), d3.max(posts, xValue)], width
#     # console.log "yScale", [d3.min(posts, yValue), d3.max(posts, yValue)], height

#     dots = canvas.selectAll(".dot")
#       .data(posts)

#     dots.enter().append("circle")
#       .attr("class", "dot")
#       .attr("r", 3.5)
#       .attr("cx", (d) -> xScale(xValue(d)))
#       .attr("cy", (d) -> yScale(yValue(d)))

#     dots.transition().duration(1000)
#       .attr("cx", (d) -> xScale(xValue(d)))
#       .attr("cy", (d) -> yScale(yValue(d)))

#     dots.exit().transition()
#       .attr("opacity", 0)
#       .remove()
#   )
# )

# _features = _.map(_.range(10), (idx) ->
#   title: "#{idx}"
#   cost: _.random(0, 5)
#   benefit: _.random(0, 5)
# )

Fixtures.addFixture("newRelease", ""
  Loading: {}
)

# Fixtures.addFixture("pokerCard", ""
#   Loading: {}
#   User:
#     featureName: "Feature name"
#     isBuilder: false
#     benefit: 1
#   Builder:
#     featureName: "Feature name"
#     isBuilder: true
#     cost: 1
#     benefit: 1
# )
