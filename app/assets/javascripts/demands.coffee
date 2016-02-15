jQuery ->
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

class MyCompleterAssist extends GmapsCompleterDefaultAssist
  positionOutputter: (latLng) ->
   $('#gmaps-output-latitude').val latLng.lat()
   $('#gmaps-output-longitude').val latLng.lng()