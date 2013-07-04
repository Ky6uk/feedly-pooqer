describe 'Options', ->
    describe 'getter', ->
        it 'has fetch_timeout option', ->
            expect(Options).to.have.property 'fetch_timeout'

        it 'fetch_timeout getting value from localStorage', ->
            localStorage.setItem 'fetch_timeout', 14
            expect(Options.fetch_timeout).to.equal 14

            localStorage.setItem 'fetch_timeout', 998
            expect(Options.fetch_timeout).to.equal 998

            localStorage.setItem 'fetch_timeout', 3
            expect(Options.fetch_timeout).to.equal 3

        it 'fetch_timeout return default value is 1', ->
            localStorage.removeItem 'fetch_timeout'
            expect(Options.fetch_timeout).to.equal 1

    describe 'setter', ->
        beforeEach ->
            chrome['alarms'] =
                clearAll: ->
                create: ->

            sinon.spy chrome.alarms, 'clearAll'
            sinon.spy chrome.alarms, 'create'

        afterEach ->
            delete chrome.alarms

        it 'fetch_timeout saves to localStorage', ->
            Options.fetch_timeout = 13
            expect(localStorage.getItem 'fetch_timeout').to.equal '13'

            Options.fetch_timeout = 512
            expect(localStorage.getItem 'fetch_timeout').to.equal '512'

            Options.fetch_timeout = 6
            expect(localStorage.getItem 'fetch_timeout').to.equal '6'

            expect(chrome.alarms.clearAll.callCount).to.equal 3
            expect(chrome.alarms.create.callCount).to.equal 3

        it 'fetch_timeout value between 1 and 999', ->
            Options.fetch_timeout = -10
            expect(Options.fetch_timeout).to.equal 1

            Options.fetch_timeout = "woof"
            expect(Options.fetch_timeout).to.equal 1

            Options.fetch_timeout = 1000
            expect(Options.fetch_timeout).to.equal 999

            Options.fetch_timeout = "30000"
            expect(Options.fetch_timeout).to.equal 999

            expect(chrome.alarms.clearAll.callCount).to.equal 4
            expect(chrome.alarms.create.callCount).to.equal 4
