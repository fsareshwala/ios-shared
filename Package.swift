// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "ios-shared",
  platforms: [
    .iOS(.v15),
  ],
  products: [
    .library(
      name: "OtherApps",
      targets: ["OtherApps"]
    ),
  ],
  targets: [
    .target(
      name: "OtherApps",
      resources: [
        .process("Resources"),
      ]
    ),
    .testTarget(
      name: "OtherAppsTests",
      dependencies: ["OtherApps"]
    ),
  ]
)
