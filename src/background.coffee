scheduleUpdater = ->
    chrome.alarms.create 'pooque',
        # DEBUG
        # periodInMinutes: 0.05
        when: Date.now() + 1000

makeXHR = ->
    xhr = new XMLHttpRequest()
    xhr.responseType = 'json'
    xhr.onload = xhrListener
    xhr.open 'get', 'http://cloud.feedly.com/v3/markers/counts'
    xhr.setRequestHeader 'Authorization', localStorage.oauth
    xhr.send()

setBadge = ->
    chrome.browserAction.setBadgeBackgroundColor
        color: [208, 0, 24, 255]

    chrome.browserAction.setBadgeText
        text: "123"

xhrListener = ->
    console.log this

# DEBUG
scheduleUpdater()
chrome.runtime.onStartup.addListener ->

chrome.browserAction.onClicked.addListener ->
    chrome.tabs.create
        url: 'http://cloud.feedly.com/'
    , (tab) ->
        console.log tab

chrome.alarms.onAlarm.addListener ->
    makeXHR()
    setBadge()
