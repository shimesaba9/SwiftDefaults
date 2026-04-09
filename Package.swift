import PackageDescription

let package = Package(
    name: "SwiftDefaults",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SwiftDefaults",
            targets: ["SwiftDefaults"]),
    ],
    targets: [
        .target(
            name: "SwiftDefaults",
            dependencies: [],
            path: "Pod"
        )
    ]
)
