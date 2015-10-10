_getPosts = ->
  Template.currentData().features
  # posts = Posts.find({}, {fields: {name: 1, cost: 1, benefit: 1}}).fetch()
  # _.each(posts, (p) ->
  #   p.cost = _.random(0, 100)
  #   p.benefit = _.random(0, 100)
  # )
  # posts

TRUNCATE = 12
_truncateLabel = (str) ->
  if _.size(str) > TRUNCATE
    "#{str.substr(0, TRUNCATE)}.."
  else
    str

Template.featureGrid.onRendered(->
  self = this
  # Set up the chart once

  posts = _getPosts()
  $chart = self.$('.js-feature-grid')
  $chart.empty()

  console.log "chartHeight", $chart.height()

  #debugger  a
  chart = d3.select($chart.get(0))
  canvas = chart.append("svg")
    .attr("width", $chart.width())
    .attr("height", $chart.height())

  mx = [20, 20]
  my = [20, 20]
  width = $chart.width() - mx[0] - mx[1]
  height = $chart.height() - my[0] - my[1]
  canvas = canvas.append('g')
    .attr('transform', "translate(#{mx[0]}, #{my[0]}) scale(1, 1)")

  canvas.append('line')
    .attr('class', 'axis')
    .attr('x1', 0)
    .attr('x2', width)
    .attr('y1', height/2)
    .attr('y2', height/2)

  canvas.append('line')
    .attr('class', 'axis')
    .attr('x1', width/2)
    .attr('x2', width/2)
    .attr('y1', 0)
    .attr('y2', height)

  canvas.append("text")
    .attr("text-anchor", "middle")
    .attr("x", .25*width)
    .attr("y", .25*height)
    .text((d) -> "High Cost x High Benefit")

  canvas.append("text")
    .attr("text-anchor", "middle")
    .attr("x", .75*width)
    .attr("y", .25*height)
    .text((d) -> "Low Cost x High Benefit")

  canvas.append("text")
    .attr("text-anchor", "middle")
    .attr("x", .25*width)
    .attr("y", .75*height)
    .text((d) -> "High Cost x Low Benefit")

  canvas.append("text")
    .attr("text-anchor", "middle")
    .attr("x", .75*width)
    .attr("y", .75*height)
    .text((d) -> "Low Cost x Low Benefit")

  @autorun(->
    # Re-render the chart reactively
    foo = Session.get("foo")
    posts = _getPosts()

    xValue = (p) -> p.cost
    yValue = (p) -> p.benefit

    xScale = d3.scale.linear()
      #.domain([d3.min(posts, xValue), d3.max(posts, xValue)])
      .domain([1, 5])
      .range([0, width])

    yScale = d3.scale.linear()
    # .domain([d3.min(posts, yValue), d3.max(posts, yValue)])
      .domain([1, 5])
      .range([0, height])

    console.log "xs", width, _.map(posts, xValue)
    console.log "ys", height, _.map(posts, yValue)

    # console.log "posts", posts
    # console.log "xScale", [d3.min(posts, xValue), d3.max(posts, xValue)], width
    # console.log "yScale", [d3.min(posts, yValue), d3.max(posts, yValue)], height

    dots = canvas.selectAll(".dot")
      .data(posts)

    g = dots.enter().append("g")
      .attr("class", "dot")
      .attr("transform", (d) -> "translate(#{width-xScale(xValue(d))}, #{height-yScale(yValue(d))})")
    g.append("rect")
      .attr("width", 100)
      .attr("height", 60)
      .attr("fill", "white")
    g.append("text")
      .attr("text-anchor", "middle")
      .attr("x", 30)
      .attr("y", 10)
      .text((d) -> _truncateLabel(d.featureName))
    g.append("text")
      .attr("text-anchor", "middle")
      .attr("x", 30)
      .attr("y", 40)
      .text((d) -> "#{d.cost} vs. #{d.benefit}")

    dots.transition().duration(1000)
      .attr("transform", (d) -> "translate(#{width-xScale(xValue(d))}, #{height-yScale(yValue(d))})")

    dots.exit().transition()
      .attr("opacity", 0)
      .remove()

    # dots.enter().append("circle")
    #   .attr("class", "dot")
    #   .attr("r", 3.5)
    #   .attr("cx", (d) -> width-xScale(xValue(d)))
    #   .attr("cy", (d) -> height-yScale(yValue(d)))
    #
    # dots.transition().duration(1000)
    #   .attr("cx", (d) -> width-xScale(xValue(d)))
    #   .attr("cy", (d) -> height-yScale(yValue(d)))
    #
    # dots.exit().transition()
    #   .attr("opacity", 0)
    #   .remove()
  )
)

_features = _.map(_.range(10), (idx) ->
  title: "Long long #{idx}"
  cost: _.random(0, 5)
  benefit: _.random(0, 5)
)

Fixtures.addFixture("featureGrid", ""
  Loading: {}
  Normal:
    features: _features
)
