class App.Views.Header extends Backbone.View

  #className: "header"
  id: "main-menu"
  template: HandlebarsTemplates["header"]

  render: ->
    #console.log @template
    @$el.html(@template())
    @