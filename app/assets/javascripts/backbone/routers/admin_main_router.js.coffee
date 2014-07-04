class App.Routers.AdminMainRouter extends Backbone.Router
  
  routes:
    "": "index"
    "questions": "question"

  initialize: ->
    @headerView = new App.Views.Header()
    @contentView = new App.Views.Content()

  index: ->
    #console.log "Hello from index"
    $("#main-menu").html(@headerView.render().el)
    $("#body-content").html(@contentView.render().el)

  question: ->
      #console.log "Hello from questions"
      @questionViews()

  questionViews: ->
    $("#main-menu").html(@headerView.render().el)
    $("#body-content").html(@contentView.render().el)