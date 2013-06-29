module.exports = (grunt) ->

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-compress'
    grunt.loadNpmTasks 'grunt-contrib-uglify'

    grunt.initConfig
        coffee:
            compile:
                options:
                    bare: true
                files:
                    'js/options.js':        'src/options.coffee'
                    'js/background.js':     'src/background.coffee'
                    'js/options-export.js': 'src/options-export.coffee'

        watch:
            files: 'src/**/*.coffee'
            tasks: ['coffee', 'uglify']

        compress:
            main:
                options:
                    archive: 'feedly-pooqer.zip'
                src: [
                    '*.html'
                    'manifest.json'
                    'img/**/*'
                    'js/**/*.min.js'
                    '_locales/**/*'
                ]

        uglify:
            feedly_pooqer:
                files:
                    'js/options.min.js':        ['js/options.js']
                    'js/background.min.js':     ['js/background.js']
                    'js/options-export.min.js': ['js/options-export.js']

    grunt.registerTask 'default', ['coffee', 'uglify', 'watch']
    grunt.registerTask 'bundle',  ['coffee', 'uglify', 'compress']
