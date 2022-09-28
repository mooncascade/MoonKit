// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MoonKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "Moonlight", targets: ["Moonlight"]),
        .library(name: "MoonlightTests", targets: ["MoonlightTests"]),
        .library(name: "MoonFoundation", targets: ["MoonFoundation"]),
        .library(name: "MoonPresentation", targets: ["MoonPresentation"])
    ],
    targets: [
        .target(name: "Moonlight"),
        .target(name: "MoonlightTests", dependencies: ["Moonlight"]),
        .target(name: "MoonFoundation"),
        .target(name: "MoonPresentation")
    ]
)
