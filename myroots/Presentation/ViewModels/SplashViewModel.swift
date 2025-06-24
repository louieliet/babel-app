import Foundation
import Combine

/// ViewModel for the initial splash screen.
final class SplashViewModel: ObservableObject {
    /// Indicates when the splash should disappear.
    @Published var isFinished: Bool = false

    private var cancellables = Set<AnyCancellable>()

    /// Starts the splash timer.
    /// - Parameter duration: Seconds to show the splash.
    func startSplash(duration: TimeInterval = 3.0) {
        Just(()).delay(for: .seconds(duration), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isFinished = true
            }
            .store(in: &cancellables)
    }
} 