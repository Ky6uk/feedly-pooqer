describe 'Helper', ->
    describe 'reduceFrequency()', ->
        it 'right setup', ->
            expect(reduceFrequency).is.a 'function'
            expect(THROTTLE_TIMEOUT).is.a('number').and.least 1000

        it.skip 'now lte throttle timeout', ->
        it.skip 'now gt throttle timeout', ->

    describe 'calculateUnread()', ->
        it 'setup', ->
            expect(calculateUnread).is.a 'function'

        it 'parsing', ->
            testData = [
                { id: 'feed/http://example.com/rss.php', count: 11 }
                { id: 'feed/http://www.example.com/rss/main/', count: 23 }
                { id: 'user/7bcde7bb7-ef90-12ab-abcd-1234567890ab/category/Other', count: 35 }
                { id: 'user/7bcde7bb7-ef90-12ab-abcd-1234567890ab/category/global.all', count: 162 }
                { id: 'user/7bcde7bb7-ef90-12ab-abcd-1234567890ab/come/wrong', count: 77 }
                { id: 'user/7bcde7bb7-ef90-12ab-abcd-1234567890ab/category/News', count: 9876 }
            ]

            expect(calculateUnread testData).is.equal 162
