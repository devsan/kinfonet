class AdminDashboardController
  init: ->
    console.log "admin dashboard init!"
    new App.Routers.AdminMainRouter
    #https://github.com/codebrew/backbone-rails/issues/134
    Backbone.history.start() unless Backbone.History.started


App.admin_dashboardController = new AdminDashboardController