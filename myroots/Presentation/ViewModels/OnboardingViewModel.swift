import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published private(set) var currentStep: Int = 0
    let totalSteps: Int
    @Published private(set) var isCompleted: Bool = false
    
    init(totalSteps: Int) {
        self.totalSteps = totalSteps
    }
    
    func nextStep() {
        if currentStep < totalSteps - 1 {
            currentStep += 1
        } else {
            isCompleted = true
        }
    }
    
    func skip() {
        isCompleted = true
    }
} 