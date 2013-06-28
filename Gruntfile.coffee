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
                    'js/background.js': 'src/background.coffee'

        watch:
            files: 'src/**/*.coffee'
            tasks: ['coffee', 'uglify']

        compress:
            main:
                options:
                    archive: 'feedly-pooqer.zip'
                src: [
                    'manifest.json'
                    'img/**/*'
                    'js/**/*.min.js'
                    '_locales/**/*'
                ]

        uglify:
            feedly_pooqer:
                files:
                    'js/background.min.js': ['js/background.js']

    grunt.registerTask 'default', ['coffee', 'uglify', 'watch']
    grunt.registerTask 'bundle', ['uglify', 'compress']
