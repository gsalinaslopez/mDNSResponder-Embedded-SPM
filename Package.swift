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
                "./mDNSPosix/Client.c",
                "./mDNSPosix/ExampleClientApp.c",
                "./mDNSPosix/mDNSPosix.c",
                "./mDNSPosix/mDNSUNP.c",
                "./mDNSCore/DNSCommon.c",
                "./mDNSCore/DNSDigest.c",
                "./mDNSCore/mDNS.c",
                "./mDNSCore/uDNS.c",
                "./mDNSShared/mDNSDebug.c",
                "./mDNSShared/GenLinkedList.c",
                "./mDNSShared/PlatformCommon.c",
            ],
            //publicHeadersPath: "./mDNSPosix/ExampleClientApp.h",
            cSettings: [
                .headerSearchPath("./mDNSPosix/ExampleClientApp.h"),
                .headerSearchPath("./mDNSPosix/mDNSPosix.h"),
                .headerSearchPath("./mDNSCore/"),
                .headerSearchPath("./mDNSShared/"),
                .headerSearchPath("./mDNSShared/utilities/"),
                .unsafeFlags([
                    "-D_GNU_SOURCE",
                    //"-DHAVE_IPV6",
                    "-DNOT_HAVE_SA_LEN",
                    "-DUSES_NETLINK",
                    "-DHAVE_LINUX",
                    //"-DTARGET_OS_LINUX",
                    //"-D_POSIX_HAS_TLS",
                    //"-ftabstop=4",
                    //"Wno-expansion-to-defined",
                    //"-g",
                    //"-DMDNS_DEBUGMSGS=0",
                ])
            ]
        ),
        .target(
          name: "CMyPoint",
        ),
        .testTarget(
            name: "CmDNSResponderTests", 
            dependencies: [
                "CmDNSResponder"
            ],
        )
    ]
)
