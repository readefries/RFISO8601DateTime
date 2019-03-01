.PHONY: install test

install:
	bundle install --path vendor/bundle

clean:
	rm -rf vendor/
	rm -rf Pods/

test:
	xcodebuild test -project RFISO8601DateTime.xcodeproj -scheme RFISO8601DateTime build test -destination platform='iOS Simulator,name=iPhone 7,OS=latest'
	bundle exec pod lib lint --quick

publish:
	bundle exec pod trunk push RFISO8601DateTime.podspec
