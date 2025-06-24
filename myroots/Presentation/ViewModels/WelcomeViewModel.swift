import Foundation
import Combine

final class WelcomeViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var showLoginSheet: Bool = false
    @Published var showOnboarding: Bool = false
    
    // MARK: - Public actions
    func openLogin() {
        showLoginSheet = true
    }
    
    func startOnboarding() {
        showOnboarding = true
    }
} 