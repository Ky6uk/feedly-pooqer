'use strict'

scheduleUpdater = ->
    period = +localStorage.getItem 'fetch_timeout'
    period = 1 if period < 1

    chrome.alarms.create 'pooque', { periodInMinutes: period }

sendRequest = ->
    if not localStorage.getItem 'oauth'
        setBadge()
        return null

    xhr = new XMLHttpRequest()
    xhr.open 'get', 'http://cloud.feedly.com/v3/markers/counts', true
    xhr.onreadystatechange = xhrReadyListener
    xhr.setRequestHeader 'Authorization', localStorage.getItem 'oauth'
    xhr.send()

calculateUnread = (unreads) ->
    for item in unreads
        continue unless item.id.match /^user\/[\da-f-]+?\/category\/global\.all$/
        return item.count

xhrReadyListener = ->
    return unless @readyState == 4

    if @status == 200
        response = JSON.parse @response
        text = calculateUnread response.unreadcounts
        text = '' if text == 0
        setBadge text
    else if @status == 401
        localStorage.removeItem 'oauth'
        setBadge()

setBadge = (badgeText) ->
    if badgeText != undefined
        imgPath = '/img/ba_36.png'
        badgeColor = [208, 0, 24, 255]
    else
        imgPath = '/img/ba_36g.png'
        badgeColor = [190, 190, 190, 230]
        badgeText = '?'

    chrome.browserAction.setIcon { path: imgPath }
    chrome.browserAction.setBadgeBackgroundColor color: badgeColor
    chrome.browserAction.setBadgeText text: badgeText.toString()

onInit = ->
    sendRequest()
    scheduleUpdater()

openFeedly = ->
    chrome.tabs.query { url: 'http://cloud.feedly.com/' }, (tabs) ->
        if tabs[0]
            tabId = tabs[0].id
            chrome.tabs.update tabId, active: true unless tabs[0].active
            return setAuth tabId
        else
            chrome.tabs.create { url: 'http://cloud.feedly.com/' }, (tab) ->
                return setAuth tab.id

setAuth = (tabId) ->
    # update counter immediately
    sendRequest()

    # can't update oauth string if already set
    # BUG: possible problem with async xhr
    return if localStorage.getItem 'oauth'

    chrome.webRequest.onBeforeSendHeaders.addListener (details) ->
        for header in details.requestHeaders
            continue unless header.name == 'X-Feedly-Access-Token'
            localStorage.setItem 'oauth', header.value
            sendRequest()
    ,
        urls: ['http://cloud.feedly.com/v3/subscriptions*']
        tabId: tabId
    , ["requestHeaders"]

chrome.alarms.onAlarm.addListener (alarm) ->
    sendRequest() if alarm.name == 'pooque'

chrome.runtime.onInstalled.addListener onInit
chrome.runtime.onStartup.addListener onInit
chrome.browserAction.onClicked.addListener openFeedly
