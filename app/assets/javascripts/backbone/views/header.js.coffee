class App.Views.Header extends Backbone.View
  tagName: "ul"
  className: "nav navbar-nav navbar-right"
  template: HandlebarsTemplates["header"]

  render: ->
    @$el.html(@template())
    @