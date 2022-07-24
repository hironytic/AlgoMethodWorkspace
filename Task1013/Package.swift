// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Task1013",
    targets: [
        .target(
            name: "TestData",
            swiftSettings: [
                .define("DEVELOPING", .when(configuration: .debug))
            ]
        ),
        .executableTarget(
            name: "Task1013",
            dependencies: ["TestData"],
            swiftSettings: [
                .define("DEVELOPING", .when(configuration: .debug))
            ]
        ),
    ]
)
