class AdminDashboardController
  init: ->
    console.log "Backbone initialization!"
    new App.Routers.AdminMainRouter
    #https://github.com/codebrew/backbone-rails/issues/134
    Backbone.history.start() unless Backbone.History.started


App.admin_dashboardController = new AdminDashboardController