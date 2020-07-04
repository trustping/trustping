.PHONY: watch
#: Build runner watch
watch:
	flutter packages pub run build_runner watch

.PHONY: build
#: Build runner
build:
	flutter packages pub run build_runner build

.PHONY: build
#: Run tests
test:
	flutter test
