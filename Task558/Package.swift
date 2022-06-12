// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Task558",
    targets: [
        .executableTarget(
            name: "Task558",
            dependencies: [],
            swiftSettings: [
                .define("DEVELOPING", .when(configuration: .debug))
            ]
        ),
    ]
)
