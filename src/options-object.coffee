'use strict'

Options = {}

Object.defineProperty Options, 'fetch_timeout',
    set: (value) ->
        value = +value

        if value < 1 then value = 1
        else if value > 30 then value = 30

        localStorage.setItem 'fetch_timeout', value

    get: ->
        return +(localStorage.getItem 'fetch_timeout') || 1