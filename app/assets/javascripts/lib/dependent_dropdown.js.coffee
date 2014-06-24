class DependentDropDown
  
  constructor: (opts) ->   
    @parentSelect = $('#' + opts["parentSelectID"])
    @childSelectWrapper = $('#' + opts['childSelectWrapperID']) 
    @action = opts['action']
    do @register_events     

  register_events: ->
    console.log "in register", @parentSelect
    @parentSelect.change @getJsonForChildSelect
  
  url: ->
    controller = $('body').data('controller')
    "/#{controller}/#{@action}"
 
  getJsonForChildSelect: =>
    $select = $('select', @childSelectWrapper)
    $select.attr('disabled', true)

    response = $.ajax(
      url: @url()
      dataType: 'json'
      type: 'get'
      cache: false
      data:
        country_code: @parentSelect.val()
      success: (data) =>
        $select.empty()
        unless $.isEmptyObject data 
          $.each data, (key, value) ->
            $('<option/>').val(value[1]).text(value[0]).appendTo($select)
            $select.removeAttr("disabled")
      error: (xhr, status, error) ->
        console.log error
    )

App.DependentDropDown = DependentDropDown 