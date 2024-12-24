// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Features",
            targets: ["Features"])
    ],
    dependencies: [
        .package(path: "../Domain")
    ],
    targets: [
        .target(
            name: "Features",
            dependencies: [.product(name: "Domain", package: "Domain")]
        ),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["Features"])
    ]
)
