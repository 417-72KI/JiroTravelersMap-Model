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
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-java", from: "0.1.2"),
    ],
    targets: [
        .target(
            name: "JiroTravelersMapModel",
            dependencies: [
                .product(name: "SwiftJava", package: "swift-java"),
            ],
            plugins: [
                .plugin(name: "JExtractSwiftPlugin", package: "swift-java")
            ]
        ),
        .testTarget(
            name: "JiroTravelersMapModelTests",
            dependencies: ["JiroTravelersMapModel"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
