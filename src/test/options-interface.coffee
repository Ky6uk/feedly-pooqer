describe 'Options Interface', ->
    it 'have a setItem method', ->
        expect(OptionsInterface)
            .to.have.property('setItem')
            .and.to.be.a 'function'

    it 'have a getItem method', ->
        expect(OptionsInterface)
            .to.have.property('getItem')
            .and.to.be.a 'function'

    describe 'setter/getter', ->
        beforeEach ->
            delete Options.__testKey__

        it 'setter pass minimum two arguments', ->
            expect(OptionsInterface.setItem)
                .to.throw TypeError, 'Not enough arguments'

            expect(OptionsInterface.setItem.bind(OptionsInterface, "__testKey__"))
                .to.throw TypeError, 'Not enough arguments'

            expect(OptionsInterface.setItem.bind(OptionsInterface, "__testKey__", '__testValue'))
                .to.not.throw TypeError, 'Not enough arguments'

        it 'getter pass minimum one argument', ->
            expect(OptionsInterface.getItem)
                .to.throw TypeError, 'Not enough arguments'

            expect(OptionsInterface.getItem.bind(OptionsInterface, "__testKey__"))
                .to.not.throw TypeError, 'Not enough arguments'

        it 'setter create new key/value pair', ->
            expect(OptionsInterface.setItem '__testKey__', '__testValue__').to.be.true
            expect(OptionsInterface.getItem '__testKey__').to.equal '__testValue__'

        it 'setter change current value', ->
            expect(OptionsInterface.setItem '__testKey__', '__testValue__').to.be.true
            expect(OptionsInterface.getItem '__testKey__').to.equal '__testValue__'
            expect(OptionsInterface.setItem '__testKey__', '__somethingDiffered__').to.be.true
            expect(OptionsInterface.getItem '__testKey__').to.equal '__somethingDiffered__'