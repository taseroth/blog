.PHONY:	assets
assets:
	mkdir -p "static/assets/js"
	curl -sS --no-progress-meter -o static/assets/js/purify.js https://raw.githubusercontent.com/cure53/DOMPurify/main/dist/purify.js
	curl -sS --no-progress-meter -o static/assets/js/purify.js.map https://raw.githubusercontent.com/cure53/DOMPurify/main/dist/purify.js.map
	curl -sS --no-progress-meter -o static/assets/js/purify.min.js https://raw.githubusercontent.com/cure53/DOMPurify/main/dist/purify.min.js
	curl -sS --no-progress-meter -o static/assets/js/purify.min.js.map https://raw.githubusercontent.com/cure53/DOMPurify/main/dist/purify.min.js.map

.PHONY: post
post:
	@if [ -z "$(name)" ]; then echo "Usage: make post name=slug"; exit 1; fi
	hugo new --kind post-bundle post/$(name)

.PHONY: build
build:
	npm run hugo -- --gc --minify --cleanDestinationDir
