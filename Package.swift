// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FDKClientSwadesh",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FDKClientSwadesh",
            targets: ["FDKClientSwadesh"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMinor(from: "5.4.4")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.3.8")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FDKClientSwadesh",
            dependencies: ["Alamofire", "CryptoSwift"],
            path: "Sources"
        ),
        .testTarget(
            name: "FDKClientSwadeshTests",
            dependencies: ["FDKClientSwadesh"],
            path: "Tests"
        ),
    ]
)
