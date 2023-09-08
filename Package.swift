// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "ConsentViewController",
  platforms: [
    .iOS(.v14),
    .tvOS(.v14),
  ],
  products: [
    .library(
      name: "ConsentViewController",
      targets: ["ConsentViewController"]),
  ],
  dependencies: [
    .package(url: "https://github.com/johnxnguyen/Down", from: "0.11.0"),
    .package(url: "https://github.com/appdev-exaring/tvos-cmp-app", from: "7.3.0")
  ],
  targets: [
    .target(
      name: "ConsentViewController",
      dependencies: [
        "Down",
        .product(name: "ConsentViewController-tvOSResources", package: "tvos-cmp-app", condition: .when(platforms: [.tvOS]))
      ],
      path: "ConsentViewController",
      exclude: [
        "Assets/javascript/SPJSReceiver.spec.js",
        "Assets/javascript/jest.config.json"
      ],
      resources: [
        .process("Assets/javascript/SPJSReceiver.js"),
        .process("Assets/images"),
      ]
    )
  ],
  swiftLanguageVersions: [.v5]
)
