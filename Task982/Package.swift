// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Task982",
    targets: [
        .executableTarget(
            name: "Task982",
            dependencies: [],
            swiftSettings: [
                .define("DEVELOPING", .when(configuration: .debug))
            ]
        ),
    ]
)
