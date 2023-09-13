// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "ConsentViewController-tvOSResources",
  platforms: [
    .tvOS(.v14)
  ],
  products: [
    .library(
      name: "ConsentViewController-tvOSResources",
      targets: ["ConsentViewController-tvOSResources"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ConsentViewController-tvOSResources",
      path: "ConsentViewController-tvOSResources"
    )
  ],
  swiftLanguageVersions: [.v5]
)
