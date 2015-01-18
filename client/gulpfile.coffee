gulp              = require 'gulp'
sass              = require 'gulp-sass'
coffee            = require 'gulp-coffee'
concat            = require 'gulp-concat'
gutil             = require 'gulp-util'
rename            = require 'gulp-rename'
clean             = require 'gulp-clean'
sh                = require 'shelljs'
size              = require 'gulp-size'

#
# Minification
uglify            = require 'gulp-uglify'
minifyHTML        = require 'gulp-minify-html'
minifyCSS         = require 'gulp-minify-css'

# Angular Helpers
ngAnnotate        = require 'gulp-ng-annotate'
htmlify           = require 'gulp-angular-htmlify'

config =
  devServerPort: 9000 # If you change this, you must also change it in protractor-conf.js

paths =
  app:
    scripts: ["src/scripts/app.{coffee,js}", "src/scripts/**/*.{coffee,js}"] # All .js and .coffee files, starting with app.coffee or app.js
    styles: "src/styles/**/*.{scss,sass,css}" # css and scss files
    pages: "src/views/*.{html,jade,md,markdown}" # All html, jade,and markdown files that can be reached directly
    templates: "src/templates/**/*.{html,jade,md,markdown}" # All html, jade, and markdown files used as templates within the app
    images: "src/images/*.{png,jpg,jpeg,gif}" # All image files
    static: "src/static/*.*" # Any other static content such as the favicon

tasks = {}

gulp.task 'scripts', ->
  gulp.src ["src/scripts/**/*.coffee"]
    .pipe(coffee({bare: true}).on("error", gutil.log))
    .pipe(ngAnnotate())
    .pipe(concat("application.js"))
    .pipe(gulp.dest("www/js"))
    .pipe(uglify())
    .pipe(rename({extname: ".min.js"}))
    .pipe(gulp.dest("www/js"))

gulp.task "styles", ->
  gulp.src("src/styles/**/*.{scss,sass}")
    .pipe(sass({
        sourcemap: false,
        unixNewlines: true,
        style: 'nested',
        debugInfo: false,
        quiet: false,
        lineNumbers: true,
        bundleExec: true
      })
      .on('error', gutil.log))
    .pipe(gulp.dest('www/css'))
    .pipe(minifyCSS())
    .pipe(rename({extname: ".min.css"}))
    .pipe(gulp.dest("www/css"))

gulp.task 'templates', tasks.templates = ->
  gulp.src paths.app.templates
    .pipe(size())
    .pipe(gulp.dest('www/templates'))
    # .pipe(livereload())
gulp.task 'templates:clean', ['clean'], tasks.templates

gulp.task 'default', ->
  gulp.start 'scripts', 'styles', 'templates'

gulp.task 'clean', ->
  gulp.src(["dist", {read: false}])
    .pipe(clean({force: true}))

gulp.task 'watch', ->
  gulp.watch(paths.app.scripts, ['scripts'])
  gulp.watch(paths.app.styles, ['styles'])
  gulp.watch paths.app.templates, ['templates']

gulp.task 'install', ['git-check'], ->
  bower.commands.install().on 'log', (data) ->
    gutil.log 'bower', gutil.colors.cyan(data.id), data.message

gulp.task 'git-check', (done) ->
  if !sh.which('git')
    console.log """
      #{gutil.colors.red 'Git is not installed.'}
      Git, the version control system, is required to download Ionic.
      Download git here: #{gutil.colors.cyan 'http://git-scm.com/downloads'}
      Once git is installed, run #{gutil.colors.cyan 'gulp install'} again
    """
    process.exit(1)
