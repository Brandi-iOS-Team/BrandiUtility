// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BrandiUtility",
    platforms: [
        .iOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BrandiUtility",
            targets: ["BrandiUtility"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa", from: "10.5.0"),
        .package(name: "ObjectMapper", url: "https://github.com/tristanhimmelman/ObjectMapper.git", from: "4.2.0"),
        .package(name: "SDWebImage", url: "https://github.com/SDWebImage/SDWebImage", from: "5.10.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BrandiUtility",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
                "SDWebImage",
                "ObjectMapper"],
            path: "Sources"),
        .testTarget(
            name: "BrandiUtilityTests",
            dependencies: ["BrandiUtility"]),
    ]
)
