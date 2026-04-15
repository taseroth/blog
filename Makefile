.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make help              - Show this help message"
	@echo "  make check             - Check required versions (node, npm, hugo)"
	@echo "  make install           - Install npm dependencies"
	@echo "  make assets            - Download DOMPurify assets"
	@echo "  make post name=<slug>  - Create a new blog post"
	@echo "  make build             - Build the site"
	@echo "  make dev               - Start Hugo dev server"
	@echo "  make clean             - Clean build artifacts"

check:
	@echo "Checking dependencies..."
	@node --version || (echo "ERROR: node is not installed" && exit 1)
	@npm --version || (echo "ERROR: npm is not installed" && exit 1)
	@echo "Node.js version: $$(node --version)"
	@if [ "$$(node --version | cut -d. -f1 | tr -d 'v')" -ge 22 ]; then \
		echo "ERROR: Node.js v22+ has ESM/CJS incompatibilities with @asciidoctor/cli v4 (yargs issue)."; \
		echo ""; \
		echo "  To fix this, please run the following command in your terminal first:"; \
		echo "  $$ nvm install 20 && nvm use 20"; \
		echo ""; \
		exit 1; \
	fi
	@npm list @asciidoctor/cli 2>/dev/null || true
	@npm list @asciidoctor/core 2>/dev/null || true
	@command -v hugo >/dev/null 2>&1 || (echo "ERROR: hugo is not installed" && exit 1)
	@hugo version
	@echo "All checks passed!"

install: check
	npm install

.PHONY: assets
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
build: check
	npm run hugo -- --gc --minify --cleanDestinationDir

.PHONY: dev
dev: check
	hugo server -D

.PHONY: clean
clean:
	hugo clean
	rm -rf public

.DEFAULT_GOAL := help
