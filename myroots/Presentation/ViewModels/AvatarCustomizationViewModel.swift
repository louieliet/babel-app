import SwiftUI

final class AvatarCustomizationViewModel: ObservableObject {
    // MARK: - Published selection
    @Published var avatarName: String = ""
    @Published var selectedSkinToneIndex: Int = 0
    @Published var selectedHairStyleIndex: Int = 0
    @Published var selectedAccessoryIndex: Int = 0
    
    var isFormValid: Bool {
        !avatarName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
} 