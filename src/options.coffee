options = {}
controlElements = {}

document.addEventListener 'DOMContentLoaded', ->
    getControls()
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

getControls = ->
    controlElements.fetch_timeout = document.getElementById 'fetch_timeout'
    controlElements.save_button   = document.getElementById 'save_button'

restoreOptions = ->
    # get saved options
    options.fetch_timeout = (localStorage.getItem 'fetch_timeout') || 1

    # fill elements with saved options
    controlElements.fetch_timeout.value = options.fetch_timeout

doSave = (event) ->
    # fetch_timeout limits
    fetch_timeout = +controlElements.fetch_timeout.value
    if fetch_timeout < controlElements.fetch_timeout.min
        fetch_timeout = +controlElements.fetch_timeout.min
    else if fetch_timeout > controlElements.fetch_timeout.max
        fetch_timeout = +controlElements.fetch_timeout.max

    options.fetch_timeout = fetch_timeout

    for own option, param of options
        localStorage.setItem option, param

    applyOptions()

applyOptions = ->
    chrome.alarms.clearAll()
    chrome.alarms.create 'pooque', { periodInMinutes: options.fetch_timeout }