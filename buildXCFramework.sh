#!/bin/bash

xcodebuild archive \
    -scheme ConsentViewController-iOS \
    -destination 'generic/platform=iOS' \
    -archivePath './build/ConsentViewController-iOS.framework-iOS.xcarchive' \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive \
    -scheme ConsentViewController-iOS \
    -destination 'generic/platform=iOS Simulator' \
    -archivePath './build/ConsentViewController-iOS.framework-iphonesimulator.xcarchive' \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES &&
xcodebuild archive \
    -scheme ConsentViewController-tvOS \
    -destination 'generic/platform=tvOS Simulator' \
    -archivePath './build/ConsentViewController-tvOS.framework-tvossimulator.xcarchive' \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES &&
xcodebuild archive \
    -scheme ConsentViewController-tvOS \
    -destination 'generic/platform=tvOS' \
    -archivePath './build/ConsentViewController-tvOS.framework-tvOS.xcarchive' \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES &&

FOLDER = ./XCFramework
if [ -d "$FOLDER" ]; then
    rm -r $FOLDER
fi

xcodebuild -create-xcframework \
    -framework './build/ConsentViewController-iOS.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/ConsentViewController.framework' \
    -framework './build/ConsentViewController-iOS.framework-iOS.xcarchive/Products/Library/Frameworks/ConsentViewController.framework' \
    -framework './build/ConsentViewController-tvOS.framework-tvossimulator.xcarchive/Products/Library/Frameworks/ConsentViewController.framework' \
    -framework './build/ConsentViewController-tvOS.framework-tvOS.xcarchive/Products/Library/Frameworks/ConsentViewController.framework' \
    -output './XCFramework/ConsentViewController.xcframework'

xcodebuild -create-xcframework \
    -framework './build/ConsentViewController-iOS.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/Down.framework' \
    -framework './build/ConsentViewController-iOS.framework-iOS.xcarchive/Products/Library/Frameworks/Down.framework' \
    -framework './build/ConsentViewController-tvOS.framework-tvossimulator.xcarchive/Products/Library/Frameworks/Down.framework' \
    -framework './build/ConsentViewController-tvOS.framework-tvOS.xcarchive/Products/Library/Frameworks/Down.framework' \
    -output './XCFramework/Down.xcframework'

zip -r ./XCFramework/ConsentViewController.xcframework.zip ./XCFramework/ConsentViewController.xcframework
zip -r ./XCFramework/Down.xcframework.zip ./XCFramework/Down.xcframework
