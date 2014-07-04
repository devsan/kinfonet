class App.Views.Content extends Backbone.View

  className: "row"
  template: HandlebarsTemplates['content']

  render: ->
    @$el.html(@template())
    #@renderEmptyView()
    @renderQuestionsView()
    @

  renderQuestionsView: ->
    console.log "in renderQuestionsView"
    view = new App.Views.Questions()
    @$el.find(".main").html(view.render().el)

  # renderEmptyView: ->
  #   console.log "in renderEmptyView"
  #   view = new App.Views.EmptyView()
  #   @$el.find(".main").html(view.render().el)

