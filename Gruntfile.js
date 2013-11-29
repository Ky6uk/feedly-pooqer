/* jshint node: true */

module.exports = function (grunt) {
    'use strict';

    grunt.loadNpmTasks('grunt-contrib-compress');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-jshint');

    grunt.initConfig({
        clean: ['*.zip', 'js/**/*.min.js'],

        compress: {
            main: {
                options: { archive: 'feedly-pooqer.zip' },
                src: [
                    'options.html',
                    'manifest.json',
                    'img/**/*',
                    'js/**/*.min.js',
                    '_locales/**/*'
                ]
            }
        },

        jshint: {
            all: ['Gruntfile.js', 'src/**/*.js']
        },

        uglify: {
            main: {
                files: {
                    'js/background.min.js': ['src/background.js']
                }
            }
        },

        watch: {
            js: {
                files: ['src/**/*.js'],
                tasks: ['jshint', 'uglify'],
                options: {
                    spawn:   false,
                    atBegin: true
                }
            }
        }
    });

    grunt.registerTask('release', ['clean', 'jshint', 'uglify', 'compress']);
    grunt.registerTask('default', ['watch']);
};
