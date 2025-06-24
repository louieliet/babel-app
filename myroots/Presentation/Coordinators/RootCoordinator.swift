import SwiftUI
import Combine

/// Very lightweight coordinator to handle the current small flow.
/// It can be expanded later with more complex navigation.
final class RootCoordinator: ObservableObject {
    enum Route {
        case splash
        case welcome
        case onboarding
        case avatar
        case personalityTest
        case mainApp
    }
    
    @Published var route: Route = .splash
    
    // ViewModels
    let splashVM = SplashViewModel()
    let welcomeVM = WelcomeViewModel()
    let onboardingVM = OnboardingViewModel(totalSteps: 3)
    let avatarVM = AvatarCustomizationViewModel()
    let personalityVM = PersonalityTestViewModel()
    
    var subscriptions = Set<AnyCancellable>()
}

// MARK: - Root View

struct RootCoordinatorView: View {
    @StateObject var coordinator = RootCoordinator()
    
    var body: some View {
        switch coordinator.route {
        case .splash:
            SplashView()
                .onAppear {
                    coordinator.splashVM.startSplash()
                    coordinator.splashVM.$isFinished
                        .filter { $0 }
                        .first()
                        .sink { _ in coordinator.route = .welcome }
                        .store(in: &coordinator.subscriptions)
                }
        case .welcome:
            WelcomeView()
        case .onboarding:
            OnboardingView()
        case .avatar:
            AvatarCustomizationView()
        case .personalityTest:
            PersonalityTestView()
        case .mainApp:
            ContentView()
        }
    }
    private var cancellables = Set<AnyCancellable>()
} 