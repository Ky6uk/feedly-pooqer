describe 'Options', ->
    it 'has fetch_timeout option', ->
        expect(Options).to.have.property 'fetch_timeout'

    it 'fetch_timeout getting value from localStorage', ->
        localStorage.setItem 'fetch_timeout', 14
        expect(Options.fetch_timeout).to.equal 14

        localStorage.setItem 'fetch_timeout', 29
        expect(Options.fetch_timeout).to.equal 29

        localStorage.setItem 'fetch_timeout', 3
        expect(Options.fetch_timeout).to.equal 3

    it 'fetch_timeout return default value is 1', ->
        localStorage.removeItem 'fetch_timeout'
        expect(Options.fetch_timeout).to.equal 1

    it.skip 'fetch_timeout saves to localStorage', ->
        Options.fetch_timeout = 14
        expect(localStorage.getItem 'fetch_timeout').to.equal 14

        Options.fetch_timeout = 29
        expect(localStorage.getItem 'fetch_timeout').to.equal 29

        Options.fetch_timeout = 3
        expect(localStorage.getItem 'fetch_timeout').to.equal 3

    it.skip 'fetch_timeout value between 1 and 30', ->
        Options.fetch_timeout = -10
        expect(Options.fetch_timeout).to.equal 1

        Options.fetch_timeout = "gay"
        expect(Options.fetch_timeout).to.equal 1

        Options.fetch_timeout = 31
        expect(Options.fetch_timeout).to.equal 30

        Options.fetch_timeout = "999"
        expect(Options.fetch_timeout).to.equal 30