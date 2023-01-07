// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "RssDecoder",
  platforms: [.iOS(.v13), .macOS(.v10_15)],
  products: [
    .library(name: "RssDecoder", targets: ["RssDecoder"]),
  ],
  dependencies: [],
  targets: [
    .target(name: "RssDecoder", dependencies: []),
    .testTarget(
      name: "RssDecoderTests",
      dependencies: ["RssDecoder"],
      resources: [.copy("Fixtures")]
    ),
  ]
)
