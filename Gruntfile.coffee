module.exports = (grunt) ->

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'

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

    grunt.registerTask 'default', ['coffee', 'watch']