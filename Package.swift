// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modeling",
    platforms: [
           .iOS(.v16),
           .macOS(.v14) // Limit the deployment of this package to iOS 16 and above, this is needed because SystemLogger makes use of the Apple SOLog framework containing the Logger implementation
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Modeling",
            targets: ["Modeling"]),
    ],
    dependencies: [
        .package(path: "../Logging")
        ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Modeling",
            dependencies: [
                .product(name: "Logging",package: "Logging")
                ]),
        .testTarget(
            name: "ModelingTests",
            dependencies: ["Modeling"]),
    ]
)
