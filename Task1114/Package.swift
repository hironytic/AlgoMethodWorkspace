// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Task1114",
    targets: [
        .target(
            name: "TestData",
            swiftSettings: [
                .define("DEVELOPING", .when(configuration: .debug))
            ]
        ),
        .executableTarget(
            name: "Task1114",
            dependencies: ["TestData"],
            swiftSettings: [
                .define("DEVELOPING", .when(configuration: .debug))
            ]
        ),
    ]
)
