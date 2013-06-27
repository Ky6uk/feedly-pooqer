chrome.runtime.onStartup.addListener ->
    scheduleAlarms()

chrome.browserAction.onClicked.addListener ->
    chrome.tabs.create
        url: 'http://cloud.feedly.com/'
    , (tab) ->
        console.log tab

chrome.alarms.onAlarm.addListener ->
    chrome.browserAction.setBadgeBackgroundColor
        color: [208, 0, 24, 255]

    chrome.browserAction.setBadgeText
        text: "123"

scheduleAlarms = ->
    chrome.alarms.create 'pooque',
        periodInMinutes: 0.05