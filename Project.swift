import ProjectDescription

let project = Project(
    name: "Muleobolram",
    organizationName: "com.GRAM-DSM",
    targets: [
        Target(
            name: "Muleobolram",
            platform: .iOS,
            product: .app,
            bundleId: "com.GRAM-DSM.Muleobolram",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            infoPlist: .file(path: Path("SupportingFiles/Info.plist")),
            sources: ["Sources/**"],
            resources: [
                "Resources/**"
            ],
            scripts: [
                .pre(
                    script: "${PODS_ROOT}/SwiftLint/swiftlint",
                    name: "SwiftLint"
                )
            ]
        )
    ]
)
