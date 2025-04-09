// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OMNetworking",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OMNetworking",
            targets: ["OMNetworking"]),
    ],
    dependencies: [.package(path: "../OMModels"),
                   .package(url: "https://github.com/hmlongco/Factory", from: Version(stringLiteral: "2.4.5"))],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OMNetworking",
            dependencies: ["OMModels", "Factory"]),
        .testTarget(
            name: "OMNetworkingTests",
            dependencies: ["OMNetworking", "OMModels", "Factory"]
        ),
    ]
)
