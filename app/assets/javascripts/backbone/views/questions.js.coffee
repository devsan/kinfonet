class App.Views.Questions extends Backbone.View

  template: HandlebarsTemplates['questions']

  render: ->
    @$el.html(@template())
    @