"use strict"

Options = {}
OptionsData = {}

# options data object

Object.defineProperty OptionsData, 'fetch_timeout',
    set: (value) ->
        value = +value

        if value < 1 then value = 1
        else if value > 30 then value = 30

        localStorage.setItem 'fetch_timeout', value

    get: ->
        return +(localStorage.getItem 'fetch_timeout') || 1

# options object

Object.defineProperty Options, "_data",
    value: Object.create OptionsData

Object.defineProperty Options, "setItem",
    value: ->
        if arguments.length < 2
            return console.error "Not enough arguments"

        OptionsData[arguments[0]] = arguments[1]

Object.defineProperty Options, "getItem",
    value: ->
        return console.error "Not enough arguments" if arguments.length < 1
        return OptionsData[arguments[0]]

Object.defineProperty Options, "storeAll",
    value: ->
        for own key, value of OptionsData
            localStorage.setItem key, value

Object.defineProperty Options, "applyAll",
    value: ->
        if OptionsData.hasOwnProperty 'fetch_timeout'
            chrome.alarms.clearAll()
            chrome.alarms.create 'pooque', { periodInMinutes: OptionsData.fetch_timeout }
        else
            console.error 'fetch_timeout is not defined'