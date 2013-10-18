/* jshint node: true */

module.exports = function (grunt) {
    'use strict';

    grunt.loadNpmTasks('grunt-contrib-compress');
    grunt.loadNpmTasks('grunt-contrib-clean');

    grunt.initConfig({
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

        clean: ['*.zip']
    });

    grunt.registerTask('default',  ['clean', 'compress']);
};
