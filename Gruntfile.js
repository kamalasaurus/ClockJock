module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    coffee: {
      main: {
        expand: true,
        cwd: "dist/scripts",
        src: ["**.coffee"],
        dest: "dist/scripts",
        ext: ".js"
      }
    },

    copy: {
      main: {
        cwd: 'src/',
        src: '**',
        dest: 'dist/',
        expand: true
      },
      angular: {
        src: 'bower_components/angular/angular.min.js',
        dest: 'dist/vendor/angular.min.js'
      }
    },

    sass: {
      main: {
        files: {
          'dist/styles/app.css': 'dist/styles/**.scss'
        }
      }
    },

    clean: {
      pre: ['dist'],
      post: ['dist/scripts/**.coffee', 'dist/styles/**.scss']
    },

    compress: {
      release: {
        options: {
          archive: 'calculator.zip',
          mode: 'zip'
        },
        files: [
          {
            src: 'dist/**'
          }
        ]
      }
    }

  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-stylus');
  grunt.loadNpmTasks('grunt-contrib-compress');

  grunt.registerTask('default', ['clean:pre', 'copy:main', 'copy:angular', 'coffee:main', 'stylus:main', 'clean:post']);
  grunt.registerTask('release', function() {
    grunt.task.run('default');
    grunt.task.run('compress:release');
  });
};