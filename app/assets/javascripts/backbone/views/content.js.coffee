class App.Views.Content extends Backbone.View

  className: "row"
  template: HandlebarsTemplates['content']

  render: ->
    @$el.html(@template())
    @

  renderNewMainView: (new_main_view) ->
    @loadCurrentView(new_main_view)
    @$('.main').html(@current_view.render().el)
    @

  loadCurrentView: (new_main_view) ->
    @currentMainView(new_main_view).remove if @currentMainView
    @current_view = new_main_view


