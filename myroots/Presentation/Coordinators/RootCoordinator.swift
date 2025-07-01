import SwiftUI
import Combine

/// Very lightweight coordinator to handle the current small flow.
/// It can be expanded later with more complex navigation.
final class RootCoordinator: ObservableObject {
    /// Representa cada destino de la aplicación. Hashable permite utilizarlo en `NavigationPath`.
    enum Route: Hashable {
        case welcome
        case onboarding
        case avatar
        case personalityTest
        case home
    }
    
    /// Pila de navegación utilizada por `NavigationStack`.
    @Published var path = NavigationPath()
    
    // ViewModels
    let splashVM = SplashViewModel()
    let onboardingVM = OnboardingViewModel(totalSteps: 3)
    let avatarVM = AvatarCustomizationViewModel()
    let personalityVM = PersonalityTestViewModel()
    let homeVM: HomeViewModel
    
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Navigation helpers
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func reset() {
        path = NavigationPath()
    }
    
    init() {
        // Inicializar el HomeViewModel y conectar acciones
        self.homeVM = HomeViewModel(
            userName: "Usuario", // Aquí puedes inyectar el nombre real
            openChat: { print("Navegar a Chat") },
            openStats: { print("Navegar a Estadísticas") },
            openMissions: { print("Navegar a Misiones") }
        )
    }
}

// MARK: - Root View basado en NavigationStack

struct RootCoordinatorView: View {
    @StateObject var coordinator = RootCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            // Pantalla raíz (Splash)
            SplashView(viewModel: coordinator.splashVM)
                .onAppear {
                    coordinator.splashVM.startSplash()
                    coordinator.splashVM.$isFinished
                        .filter { $0 }
                        .sink { _ in coordinator.push(.welcome) }
                        .store(in: &coordinator.subscriptions)
                }
                // Mapeo de destinos
                .navigationDestination(for: RootCoordinator.Route.self) { route in
                    switch route {
                    case .welcome:
                        WelcomeView(onStart: { coordinator.push(.onboarding) })
                    case .onboarding:
                        OnboardingView(
                            viewModel: coordinator.onboardingVM,
                            onFinish: { coordinator.push(.avatar) }
                        )
                    case .avatar:
                        AvatarCustomizationView(
                            viewModel: coordinator.avatarVM,
                            onContinue: { coordinator.push(.personalityTest) }
                        )
                    case .personalityTest:
                        PersonalityTestView(
                            viewModel: coordinator.personalityVM,
                            onTestComplete: { coordinator.push(.home) }
                        )
                    case .home:
                        HomeView(viewModel: coordinator.homeVM)
                    }
                }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
} 