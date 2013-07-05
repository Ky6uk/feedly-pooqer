'use strict'

THROTTLE_TIMEOUT = 10000

reduceFrequency =  ->
    now = Date.now()
    lastFetch = +(localStorage.getItem 'last_fetch')

    if not lastFetch or (now - lastFetch) > THROTTLE_TIMEOUT
        localStorage.setItem 'last_fetch', now
        return true

    return false

calculateUnread = (unreads) ->
    for item in unreads
        console.log item
        continue unless item.id.match /^user\/[\da-f-]+?\/category\/global\.all$/
        return item.count