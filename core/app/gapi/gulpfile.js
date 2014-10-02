var gulp = require('gulp');
var coffee = require('gulp-coffee');

var paths = {
  scripts: {
    in: 'src/**/*coffee',
    out: 'lib'
  },
  tests: {
    in: 'test/**/*coffee',
    out: 'test/lib'
  }
};

gulp.task('scripts', function() {
  return gulp.src(paths.scripts.in)
    .pipe(coffee())
    .pipe(gulp.dest(paths.scripts.out));
});

gulp.task('tests', function() {
  return gulp.src(paths.tests.in)
    .pipe(coffee())
    .pipe(gulp.dest(paths.tests.out));
});

gulp.task('watch', function() {
  gulp.watch(paths.scripts.in, ['scripts']);
  gulp.watch(paths.tests.in, ['tests']);
});

gulp.task('default', ['scripts', 'tests', 'watch']);
