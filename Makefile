.PHONY: run run-dev run-web-dev run-web build build-ios build-apk build-appbundle build-model test coverage watch help

help:
	@echo "make run 執行default app"
	@echo "make run-web 執行web app"
	@echo "make build 建置"
	@echo "make build-ios 建置iOS"
	@echo "make build-apk 建置APK"
	@echo "make build-appbundle 建置appbundle"
	@echo "make build-model 編譯元件"
	@echo "make test 測試元件"
	@echo "make coverage 產生測試報告"
	@echo "make watch 即時編譯"	
	@echo "make update-build-number 上升一個版本號"	

run:
	@flutter run

run-web:
	@flutter run -d web-server --web-port=3000

build: build-ios build-apk build-appbundle

build-ios:
	@echo 'Build iOS'
	@flutter build ios --release

build-apk:
	@echo 'Build Android'
	@flutter build apk --release

build-appbundle:
	@echo 'Build Android App Bundle'
	@flutter build appbundle --release


build-model:
	@dart run build_runner build --delete-conflicting-outputs

test:
	@flutter test

coverage:
	@sh gencov.sh

watch:
	@dart pub run build_runner watch
