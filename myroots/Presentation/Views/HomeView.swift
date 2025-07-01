import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedMood: MoodOption?
    @State private var dailyReflection: String = ""
    @State private var showReflectionInput = false

    var body: some View {
        ZStack {
            // Fondo suave con gradiente babel consistente
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.babelLight,
                    Color.white,
                    Color.babelMedium.opacity(0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
                         // Elementos decorativos de fondo - árboles estilizados
             GeometryReader { geometry in
                 // Árboles del fondo usando TreeLogoView
                 TreeLogoView(size: 60)
                     .opacity(0.08)
                     .offset(x: geometry.size.width * 0.1, y: geometry.size.height * 0.6)
                 
                 TreeLogoView(size: 40)
                     .opacity(0.06)
                     .offset(x: geometry.size.width * 0.8, y: geometry.size.height * 0.7)
                 
                 TreeLogoView(size: 80)
                     .opacity(0.05)
                     .offset(x: geometry.size.width * 0.6, y: geometry.size.height * 0.5)
             }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header con saludo personalizado
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                                                         VStack(alignment: .leading, spacing: 4) {
                                 Text("Bienvenido de vuelta,")
                                     .font(.system(size: 16, weight: .medium))
                                     .foregroundColor(Color.babelDark.opacity(0.7))
                                 
                                 Text(viewModel.userName)
                                     .font(.system(size: 28, weight: .bold))
                                     .foregroundColor(Color.babelDark)
                             }
                            
                            Spacer()
                            
                            // Avatar con TreeLogo
                            ZStack {
                                Circle()
                                    .fill(Color.babelAccent.opacity(0.3))
                                    .frame(width: 50, height: 50)
                                
                                TreeLogoView(size: 30)
                            }
                        }
                        
                                                 Text("Tu progreso y bienestar actual")
                             .font(.system(size: 14, weight: .regular))
                             .foregroundColor(Color.babelDark.opacity(0.6))
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 60)
                    .padding(.bottom, 32)
                    
                    // Card principal con mood y reflexión
                    VStack(spacing: 0) {
                        // Daily Mood Log
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Daily Mood Log")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.babelDark)
                            
                            // Selector de mood elegante
                            HStack(spacing: 16) {
                                ForEach(viewModel.moodOptions, id: \.self) { mood in
                                    Button(action: {
                                        selectedMood = mood
                                    }) {
                                        VStack(spacing: 8) {
                                            ZStack {
                                                Circle()
                                                    .fill(selectedMood == mood ? mood.color.opacity(0.3) : Color.gray.opacity(0.1))
                                                    .frame(width: 48, height: 48)
                                                
                                                Text(moodEmoji(for: mood))
                                                    .font(.system(size: 24))
                                            }
                                            .scaleEffect(selectedMood == mood ? 1.1 : 1.0)
                                            .animation(.spring(response: 0.3), value: selectedMood)
                                            
                                            Text(mood.label)
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(selectedMood == mood ? Color.babelDark : Color.gray)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 8)
                        }
                        .padding(.top, 28)
                        .padding(.horizontal, 24)
                        
                        // Daily Reflection Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Daily Reflection")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.babelDark)
                            
                            Text("¿Cómo te sientes acerca de tus emociones actuales?")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color.babelDark.opacity(0.7))
                            
                            // Campo de reflexión
                            Button(action: {
                                showReflectionInput = true
                            }) {
                                HStack {
                                    Text(dailyReflection.isEmpty ? "Tu reflexión..." : dailyReflection)
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(dailyReflection.isEmpty ? Color.gray : Color.babelDark)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "pencil")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.babelPrimary)
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.babelLight.opacity(0.5))
                                        .stroke(Color.babelMedium.opacity(0.3), lineWidth: 1)
                                )
                            }
                        }
                        .padding(.top, 32)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 28)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.ultraThinMaterial)
                    )
                    .padding(.horizontal, 20)
                    
                    // Quick Actions Section
                    VStack(alignment: .leading, spacing: 20) {
                                                 Text("Accesos Rápidos")
                             .font(.system(size: 18, weight: .semibold))
                             .foregroundColor(Color.babelDark)
                             .padding(.horizontal, 24)
                        
                        HStack(spacing: 12) {
                            QuickActionCard(
                                title: "Chat",
                                subtitle: "Habla con tu compañero emocional",
                                iconName: "message.fill",
                                color: Color.babelSecondary,
                                action: viewModel.openChat
                            )
                            
                            QuickActionCard(
                                title: "Estadísticas",
                                subtitle: "Tu progreso",
                                iconName: "chart.bar.fill",
                                color: Color.babelAccent,
                                action: viewModel.openStats
                            )
                            
                            QuickActionCard(
                                title: "Misiones",
                                subtitle: "Nuevos retos",
                                iconName: "target",
                                color: Color.babelMedium,
                                action: viewModel.openMissions
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 32)
                    
                    Spacer(minLength: 120) // Espacio para el TabBar
                }
            }
            
            // Tab Bar en la parte inferior
            VStack {
                Spacer()
                TabBarView(selectedTab: $viewModel.selectedTab)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .sheet(isPresented: $showReflectionInput) {
            ReflectionInputView(reflection: $dailyReflection)
        }
    }
    
    // Helper function para emojis
    private func moodEmoji(for mood: MoodOption) -> String {
        switch mood.label {
        case "Feliz": return "😊"
        case "Contento": return "😌"
        case "Neutral": return "😐"
        case "Triste": return "😢"
        case "Enojado": return "😠"
        default: return "😐"
        }
    }
}

// Quick Action Card Component
struct QuickActionCard: View {
    let title: String
    let subtitle: String
    let iconName: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                                 VStack(spacing: 4) {
                     Text(title)
                         .font(.system(size: 16, weight: .semibold))
                         .foregroundColor(Color.babelDark)
                     
                     Text(subtitle)
                         .font(.system(size: 12, weight: .regular))
                         .foregroundColor(Color.babelDark.opacity(0.7))
                         .multilineTextAlignment(.center)
                         .lineLimit(2)
                 }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.babelLight.opacity(0.2), lineWidth: 1)
                    )
            )
        }
    }
}

// Reflection Input Modal
struct ReflectionInputView: View {
    @Binding var reflection: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("¿Cómo te sientes hoy?")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.babelDark)
                
                Text("Tómate un momento para reflexionar sobre tus emociones actuales")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.babelDark.opacity(0.7))
                
                TextEditor(text: $reflection)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.babelLight.opacity(0.3))
                            .stroke(Color.babelMedium.opacity(0.5), lineWidth: 1)
                    )
                    .frame(minHeight: 120)
                    .font(.system(size: 16))
                
                Spacer()
            }
            .padding(24)
            .background(Color.babelLight.opacity(0.95))
            .navigationTitle("Reflexión Diaria")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundColor(Color.babelPrimary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        dismiss()
                    }
                    .foregroundColor(Color.babelPrimary)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

// Enum para las pestañas del TabBar
enum HomeTab: String, CaseIterable {
    case home = "Inicio"
    case explore = "Explorar"
    case stats = "Estadísticas"
    case settings = "Ajustes"

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .explore: return "safari.fill"
        case .stats: return "chart.bar.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

// Vista personalizada del TabBar
struct TabBarView: View {
    @Binding var selectedTab: HomeTab

    var body: some View {
        HStack {
            ForEach(HomeTab.allCases, id: \.self) { tab in
                Spacer()
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(selectedTab == tab ? Color.babelPrimary : Color.babelMedium)
                        Text(tab.rawValue)
                            .font(.caption2)
                            .foregroundColor(selectedTab == tab ? Color.babelPrimary : Color.babelMedium)
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 6)
        .padding(.bottom, 18)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.babelLight.opacity(0.3), lineWidth: 1)
                )
        )
        .padding(.horizontal, 24)
    }
} 


