Template.bubbles.onRendered(->
  $chart = self.$('#large-header')
  $('<canvas>').attr({
    id: "demo-canvas"
  }).css({
    width: $chart.width() + 'px',
    height: $chart.height() + 'px'
  }).appendTo($chart)

  Meteor.setTimeout(->
    Bubbles.initHeader("large-header", "demo-canvas")
    Bubbles.addListeners()
  , 100)
)
