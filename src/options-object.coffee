'use strict'

Options = {}

Object.defineProperty Options, 'fetch_timeout',
    set: (value) ->
        value = +value

        if value < 1 then value = 1
        else if value > 999 then value = 999

        chrome.alarms.clearAll()
        chrome.alarms.create 'pooque', { periodInMinutes: value }

        localStorage.setItem 'fetch_timeout', value

    get: ->
        return +(localStorage.getItem 'fetch_timeout') || 1
