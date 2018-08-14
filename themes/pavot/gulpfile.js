// gulp tasks to compile sass to css
// taken from:
// http://danbahrami.io/articles/building-a-production-website-with-hugo-and-gulp-js/

var gulp         = require("gulp"),
    sass         = require("gulp-sass"),
    autoprefixer = require("gulp-autoprefixer"),
    del          = require("del");

// Compile SCSS files to CSS
gulp.task("scss", function () {
    del(["static/css/**/*"]);
    gulp.src("src/scss/**/*.scss")
        .pipe(sass({outputStyle : "compressed"}))
        .pipe(autoprefixer({browsers : ["last 20 versions"]}))
        .pipe(gulp.dest("static/css"));
});

// copy images images
gulp.task("images", function () {
    del(["static/images/**/*"]);
    gulp.src("src/images/**/*")
        .pipe(gulp.dest("static/images"));
});

// copy javascript
gulp.task("js", function () {
    del(["static/js/**/*"]);
    gulp.src("src/js/**/*")
        .pipe(gulp.dest("static/js"));
});

// Watch asset folder for changes
gulp.task("watch", ["scss", "images", "js"], function () {
    gulp.watch("src/scss/**/*", ["scss"]);
    gulp.watch("src/images/**/*", ["images"]);
    gulp.watch("src/js/**/*", ["js"])
});

// Set watch as default task
gulp.task("default", ["watch"]);