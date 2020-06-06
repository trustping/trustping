.PHONY: watch
watch:
	flutter packages pub run build_runner watch

.PHONY: build
build:
	flutter packages pub run build_runner build
