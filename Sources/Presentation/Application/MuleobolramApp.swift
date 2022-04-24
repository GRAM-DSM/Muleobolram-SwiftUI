import SwiftUI

import Swinject

@main
struct MuleobolramApp: App {
    var container: Container = {
        let container = Container()
        container.registerServiceDependencies()
        return container
    }()

// MARK: App
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
