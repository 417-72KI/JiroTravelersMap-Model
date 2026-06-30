// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JiroTravelersMapModel",
    platforms: [.macOS(.v15), .iOS(.v18)],
    products: [
        .library(
            name: "JiroTravelersMapModel",
            targets: ["JiroTravelersMapModel"]
        ),        
    ],
    targets: [
        .target(name: "JiroTravelersMapModel"),
        .testTarget(
            name: "JiroTravelersMapModelTests",
            dependencies: ["JiroTravelersMapModel"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
