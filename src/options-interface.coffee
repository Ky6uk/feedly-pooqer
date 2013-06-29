OptionsInterface = {}

# options object
Object.defineProperty OptionsInterface, "setItem",
    value: ->
        if arguments.length < 2
            return console.error "Not enough arguments"

        Options[arguments[0]] = arguments[1]

Object.defineProperty OptionsInterface, "getItem",
    value: ->
        return console.error "Not enough arguments" if arguments.length < 1
        return Options[arguments[0]]

Object.defineProperty OptionsInterface, "applyAll",
    value: ->
        if Options.hasOwnProperty 'fetch_timeout'
            chrome.alarms.clearAll()
            chrome.alarms.create 'pooque', { periodInMinutes: Options.fetch_timeout }
        else
            console.error 'fetch_timeout is not defined'