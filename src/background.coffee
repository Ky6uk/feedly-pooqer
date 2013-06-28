scheduleUpdater = ->
    chrome.alarms.get 'pooque', (alarm) ->
        chrome.alarms.create 'pooque', { periodInMinutes: 1 } unless alarm

sendRequest = ->
    unless localStorage.oauth
        chrome.browserAction.setIcon { path: '/img/48g.png' }
        chrome.browserAction.setBadgeBackgroundColor color: [190, 190, 190, 230]
        chrome.browserAction.setBadgeText text: '?'
        return null

    xhr = new XMLHttpRequest()
    xhr.open 'get', 'http://cloud.feedly.com/v3/markers/counts', true
    xhr.onreadystatechange = xhrReadyListener
    xhr.setRequestHeader 'Authorization', localStorage.oauth
    xhr.send()

calculateUnread = (unreads) ->
    for item in unreads
        continue unless item.id.match /^user\/[\da-f-]+?\/category\/global\.all$/
        return item.count

xhrReadyListener = ->
    return unless @readyState == 4

    if @status == 200
        color = [208, 0, 24, 255]
        response = JSON.parse @response
        text = calculateUnread response.unreadcounts
    else if @status == 401
        localStorage.removeItem 'oauth'

    chrome.browserAction.setIcon { path: '/img/48.png' }
    chrome.browserAction.setBadgeBackgroundColor color: color
    chrome.browserAction.setBadgeText text: "#{text}"

onInit = ->
    chrome.alarms.clearAll()
    sendRequest()
    scheduleUpdater()

chrome.runtime.onInstalled.addListener ->
    onInit()

chrome.runtime.onStartup.addListener ->
    onInit()

chrome.browserAction.onClicked.addListener ->
    chrome.tabs.create { url: 'http://cloud.feedly.com/' }, (tab) ->
        # update counter immediately
        sendRequest()

        # can't update oauth string if already set
        # BUG: possible problem with async xhr
        return if localStorage.oauth

        chrome.webRequest.onBeforeSendHeaders.addListener (details) ->
            for header in details.requestHeaders
                continue unless header.name == 'X-Feedly-Access-Token'
                localStorage.oauth = header.value
                sendRequest()
        ,
            urls: ['http://cloud.feedly.com/v3/subscriptions*']
            tabId: tab.id
        , ["requestHeaders"]

chrome.alarms.onAlarm.addListener ->
    sendRequest()