import Foundation
import Combine
import SwiftUI

struct MoodOption: Hashable {
    let icon: String
    let label: String
    let color: Color
}

class HomeViewModel: ObservableObject {
    @Published var userName: String = "Usuario" // Esto puede ser inyectado o cargado desde el dominio
    
    // Nuevo: pestaña seleccionada para el TabBar
    @Published var selectedTab: HomeTab = .home
    
    // Opciones de estado de ánimo
    @Published var moodOptions: [MoodOption] = [
        MoodOption(icon: "smiley", label: "Feliz", color: .yellow),
        MoodOption(icon: "face.smiling", label: "Contento", color: .green),
        MoodOption(icon: "face.dashed", label: "Neutral", color: .gray),
        MoodOption(icon: "face.sad.tear", label: "Triste", color: .blue),
        MoodOption(icon: "flame.fill", label: "Enojado", color: .red)
    ]
    
    // Acciones de navegación
    var openChat: () -> Void = {}
    var openStats: () -> Void = {}
    var openMissions: () -> Void = {}
    
    init(userName: String = "Usuario",
         openChat: @escaping () -> Void = {},
         openStats: @escaping () -> Void = {},
         openMissions: @escaping () -> Void = {}) {
        self.userName = userName
        self.openChat = openChat
        self.openStats = openStats
        self.openMissions = openMissions
    }
} 