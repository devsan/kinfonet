class App.Views.Questions extends Backbone.View

  className: 'js-content-view-wrapper main'
  template: HandlebarsTemplates['questions']

  initialize: ->
    #console.log @collection
    @listenTo @collection, "reset", @render
    @collection.fetch({ reset:true })

  render: ->
    @$el.html(@template())
    @collection.each @renderQuestion, @
    @

  renderQuestion: (question_model) ->
    view = new App.Views.Question(model: question_model)
    @$("ul.questions").append(view.render().el)