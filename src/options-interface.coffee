OptionsInterface = {}

# options object
Object.defineProperty OptionsInterface, "setItem",
    value: ->
        if arguments.length < 2
            throw TypeError 'Not enough arguments'

        Options[arguments[0]] = arguments[1]

        return true

Object.defineProperty OptionsInterface, "getItem",
    value: ->
        throw TypeError 'Not enough arguments' if arguments.length < 1
        return Options[arguments[0]]
