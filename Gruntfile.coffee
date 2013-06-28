module.exports = (grunt) ->

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-compress'

    grunt.initConfig
        coffee:
            compile:
                options:
                    bare: true
                files:
                    'js/background.js': 'src/background.coffee'

        watch:
            files: 'src/**/*.coffee'
            tasks: ['coffee']

        compress:
            main:
                options:
                    archive: 'feedly-pooqer.zip'
                src: [
                    'manifest.json'
                    'img/**/*'
                    'js/**/*'
                    '_locales/**/*'
                ]

    grunt.registerTask 'default', ['coffee', 'watch']