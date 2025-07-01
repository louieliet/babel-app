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
    
    /// Permite actualizar el paso actual desde la vista (por ejemplo, cuando el usuario desliza en el `TabView`).
    /// Mantiene el encapsulamiento evitando exponer el setter directamente.
    /// - Parameter step: Índice del paso a mostrar.
    func setCurrentStep(_ step: Int) {
        guard step >= 0 && step < totalSteps else { return }
        currentStep = step
    }
} 