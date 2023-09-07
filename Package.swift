// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "ConsentViewController",
  platforms: [
    .iOS(.v11),
    .tvOS(.v14)
  ],
  products: [
    .library(
      name: "ConsentViewController",
      targets: [
        "ConsentViewController",
        "ConsentViewController-iOS",
        "ConsentViewController-tvOS"
      ]),
  ],
  dependencies: [
    .package(url: "https://github.com/johnxnguyen/Down", from: "0.11.0"),
  ],
  targets: [
    .target(
      name: "ConsentViewController",
      path: "ConsentViewController",
      exclude: [
        "Assets/javascript/SPJSReceiver.spec.js",
        "Assets/javascript/jest.config.json",
        "Classes/Views"
      ],
      resources: [
        .process("Assets/javascript/SPJSReceiver.js"),
        .process("Assets/images")
      ]
    ),
    .target(
      name: "ConsentViewController-iOS",
      dependencies: ["ConsentViewController"],
      path: "ConsentViewController/Classes/Views/iOS"
    ),
    .target(
      name: "ConsentViewController-tvOS",
      dependencies: ["Down", "ConsentViewController"],
      path: "ConsentViewController/Classes/Views/tvOS"
    )
  ],
  swiftLanguageVersions: [.v5]
)
