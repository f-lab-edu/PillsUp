// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../NetworkKit"),
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                .product(name: "NetworkKit", package: "NetworkKit"),
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]),
    ]
)

