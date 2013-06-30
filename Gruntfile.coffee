module.exports = (grunt) ->

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-compress'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-clean'

    grunt.initConfig
        coffee:
            compile:
                options:
                    bare: true
                files:
                    'js/options-object.js':    'src/options-object.coffee'
                    'js/options-interface.js': 'src/options-interface.coffee'
                    'js/options.js':           'src/options.coffee'
                    'js/background.js':        'src/background.coffee'

                    # test suits
                    'test/options-object.test.js': 'src/test/options-object.coffee'

        watch:
            files: 'src/**/*.coffee'
            tasks: ['coffee', 'uglify']

        compress:
            main:
                options:
                    archive: 'feedly-pooqer.zip'
                src: [
                    'options.html'
                    'manifest.json'
                    'img/**/*'
                    'js/**/*.min.js'
                    '_locales/**/*'
                ]

        uglify:
            feedly_pooqer:
                files:
                    'js/options.min.js':    ['options-object.js', 'js/options-interface.js', 'js/options.js']
                    'js/background.min.js': ['js/background.js']

        clean: ['js/**/*', 'test/**/*', '*.zip']

    grunt.registerTask 'default', ['coffee', 'uglify', 'watch']
    grunt.registerTask 'bundle',  ['clean', 'coffee', 'uglify', 'compress']
