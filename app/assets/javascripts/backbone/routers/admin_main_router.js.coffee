class App.Routers.AdminMainRouter extends Backbone.Router
  
  routes:
    "": "index"

  initialize: ->
    @headerView = new App.Views.Header
    @contentView = new App.Views.Content

  index: ->
    console.log "Hello from Router"
    $("#main-menu").html(@headerView.render().el)
    $("#body-content").html(@contentView.render().el)
