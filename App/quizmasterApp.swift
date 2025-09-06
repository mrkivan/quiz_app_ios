import SwiftUI
import Resolver

@main
struct quizmasterApp: App {
    init() {
        Resolver.registerAllServices()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack(alignment: .top) {
                    Color.white
                        .ignoresSafeArea() // remove safe area background

                    DashboardView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}
