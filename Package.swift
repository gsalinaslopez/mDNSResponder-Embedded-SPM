// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyCLI",
    products: [
        .library(name: "CmDNSResponder", targets:["CmDNSResponder"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CmDNSResponder",
            exclude: [
                "./mDNSWindows",
            ],
            sources: [
                "./mDNSPosix/ExampleClientApp.c",
                //"./mDNSCore/mDNSEmbeddedAPI.c",
                /*
                "./mDNSCore",
                "./mDNSShared",
                */
            ],
            cSettings: [
                .headerSearchPath("./mDNSPosix/ExampleClientApp.h"),
                .headerSearchPath("./mDNSCore/"),
                //.headerSearchPath("./mDNSCore/mDNSEmbeddedAPI.h"),
                /*
                .headerSearchPath("./mDNSCore"),
                .headerSearchPath("./mDNSShared"),
                .headerSearchPath("./include")
                */
            ]
        ),
        .target(
          name: "CMyPoint",
        ),
        .executableTarget(
            name: "MyCLI", dependencies: [
                .target(name: "CMyPoint"),
                // .target(name: "CmDNSResponder")
            ]
        ),
    ]
)
