controlElements = {}

document.addEventListener 'DOMContentLoaded', ->
    controlElements.fetch_timeout = document.getElementById 'fetch_timeout'
    controlElements.save_button   = document.getElementById 'save_button'

    localizePage()
    restoreOptions()

    # apply DOM events
    controlElements.save_button.addEventListener 'click', doSave

localizePage = ->
    document.title = (chrome.i18n.getMessage 'options_title') + ' | Feedly Pooqer'
    controlElements.save_button.innerHTML =
        chrome.i18n.getMessage 'options_save_button'
    (document.getElementById 'fetch_timeout_label').innerHTML =
        chrome.i18n.getMessage 'options_fetch_timeout'

restoreOptions = ->
    controlElements.fetch_timeout.value = OptionsInterface.getItem 'fetch_timeout'

doSave = (event) ->
    OptionsInterface.setItem 'fetch_timeout', controlElements.fetch_timeout.value
    OptionsInterface.applyAll()