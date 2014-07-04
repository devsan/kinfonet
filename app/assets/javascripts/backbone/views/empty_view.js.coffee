class App.Views.EmptyView extends Backbone.View

  className: "white-well"

  render: ->
    @$el.html("Choose a question from the left")
    console.log(@$el)
    @