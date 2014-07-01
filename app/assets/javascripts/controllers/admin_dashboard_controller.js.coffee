class AdminDashboardController
  init: ->
    console.log "admin dashboard init!"
    new App.Routers.AdminMainRouter
    Backbone.history.start()

App.admin_dashboardController = new AdminDashboardController