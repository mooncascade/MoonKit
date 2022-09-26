// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MoonKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MoonKitTests",
            targets: [
                "MoonlightTests"
            ]
        ),
        .library(
            name: "MoonKit",
            targets: [
                "Moonlight",
                "MoonFoundation",
                "MoonPresentation"
            ]
        )
    ],
    targets: [
        .target(name: "Moonlight"),
        .target(name: "MoonlightTests"),
        .target(name: "MoonFoundation"),
        .target(name: "MoonPresentation")
    ]
)
