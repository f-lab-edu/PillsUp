// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]),
    ],
    dependencies: [
        .package(path: "../Shared")
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: [.product(name: "Shared", package: "Shared")]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]),
    ]
)
