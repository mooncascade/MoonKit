// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MoonKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MoonKit",
            targets: [
                "MoonFoundation",
                "MoonPresentation"
            ]
        )
    ],
    targets: [
        .target(name: "MoonFoundation"),
        .target(name: "MoonPresentation")
    ]
)
