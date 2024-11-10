// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Down",
    platforms: [
        .macOS("10.11"),
        .iOS("9.0"),
        .tvOS("9.0")
    ],
    products: [
        .library(
            name: "Down",
            targets: ["Down"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-cmark", .upToNextMajor(from: "0.5.0")),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", .upToNextMinor(from: "1.17.6"))
    ],
    targets: [
        .target(
            name: "Down",
            dependencies: [
              .product(name: "cmark-gfm", package: "swift-cmark"),
              .product(name: "cmark-gfm-extensions", package: "swift-cmark")
            ],
            path: "Sources/Down",
            exclude: ["Down.h"],
          resources: [
            .copy("Resources/DownView.bundle"),
            .copy("Resources/DownView (macOS).bundle"),
          ]
        ),
        .testTarget(
            name: "DownTests",
            dependencies: [
                "Down",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            path: "Tests/DownTests",
            exclude: [
                "AST/VisitorTests.swift",
                "AST/__Snapshots__",
                "DownViewTests.swift",
                "Fixtures",
                "Styler/__Snapshots__",
                "Styler/BlockQuoteStyleTests.swift",
                "Styler/CodeBlockStyleTests.swift",
                "Styler/DownDebugLayoutManagerTests.swift",
                "Styler/HeadingStyleTests.swift",
                "Styler/LinkStyleTests.swift",
                "Styler/InlineStyleTests.swift",
                "Styler/ListItemStyleTests.swift",
                "Styler/StylerTestSuite.swift",
                "Styler/ThematicBreakSyleTests.swift"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
