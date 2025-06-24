import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    // MARK: - Input
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - Output
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var loginSucceeded: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Validation
    var canSubmit: Bool {
        !email.isEmpty && !password.isEmpty && email.contains("@")
    }
    
    // MARK: - Actions
    func login() {
        guard canSubmit else { return }
        isLoading = true
        // Simulate async auth.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            self.isLoading = false
            // For MVP we assume success.
            self.loginSucceeded = true
        }
    }
} 