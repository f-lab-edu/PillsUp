// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    products: [
        .library(
            name: "Network",
            targets: ["Network"]),
    ],
    dependencies: [
        .package(path: "../Shared")
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [.product(name: "Shared", package: "Shared")]
        ),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]),
    ]
)
