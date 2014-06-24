class UsersController
  # init: ->
  #   console.log "users init!"

  index: ->
    #console.log "users index!"

  edit: ->
    #console.log "users edit!"
    opts = 
      parentSelectID: 'js-country-select'
      childSelectWrapperID: 'js-state-select-wrapper'
      action: 'get_states'
    stateSelector = new App.DependentDropDown opts

App.usersController = new UsersController