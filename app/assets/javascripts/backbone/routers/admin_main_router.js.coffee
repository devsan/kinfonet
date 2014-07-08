class App.Routers.AdminMainRouter extends Backbone.Router
  
  routes:
    "": "index"
    "questions": "question"

  initialize: ->
    #console.log "in main router"
    @headerView = new App.Views.Header()
    @contentView = new App.Views.Content()

  index: ->
    #console.log "Hello from router #index"
    $("#main-menu").html(@headerView.render().el)
    $('#js-content-view-wrapper').html(@contentView.render().el)

  question: ->
    #console.log "Hello from router #question"
    $("#main-menu").html(@headerView.render().el)
    questionsMainView = new App.Views.Questions(collection: new App.Collections.Questions())
    mainContentView = @contentView.render()
                      .renderNewMainView(questionsMainView)
    $('#js-content-view-wrapper').html(mainContentView.el)