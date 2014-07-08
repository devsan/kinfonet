class App.Views.Question extends Backbone.View

  tagName: "li" 
  template: HandlebarsTemplates['question']

  render: ->
    @$el.html(@template(@model.toJSON()))
    @