jQuery ->
  $("#school_cep").mask("99999-999");
  completer = new GmapsCompleter
    inputField: '#gmaps-input-address'
    errorField: '#gmaps-error'
    assist: MyCompleterAssist

  completer.autoCompleteInit
    country: 'br'
    autocomplete:
      minLength: 6
      position:
        my: 'center top'
        at: 'center bottom'
  $(document).on 'change', '#states_select', (evt) ->
    $.ajax 'update_cities',
      type: 'GET'
      dataType: 'script'
      data: {
        state_id: $("#states_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")



class MyCompleterAssist extends GmapsCompleterDefaultAssist
  positionOutputter: (latLng) ->
   $('#gmaps-output-latitude').val latLng.lat()
   $('#gmaps-output-longitude').val latLng.lng()