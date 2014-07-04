class App.Views.Content extends Backbone.View

  className: "row"
  template: HandlebarsTemplates['content']

  render: ->
    @$el.html(@template())
    @