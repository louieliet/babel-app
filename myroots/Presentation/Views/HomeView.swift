import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedMood: MoodOption?
    @State private var dailyReflection: String = ""
    @State private var showReflectionInput = false
    
    // Playful animation states
    @State private var breathingScale: CGFloat = 1.0
    @State private var floatingOffset: CGFloat = 0
    @State private var sparkleRotation: Double = 0
    @State private var treeAnimation1: CGFloat = 0
    @State private var treeAnimation2: CGFloat = 0
    @State private var treeAnimation3: CGFloat = 0
    @State private var showContent = false

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
            
            // Elementos decorativos flotantes mejorados
            GeometryReader { geometry in
                // Árboles del fondo con animaciones orgánicas
                TreeLogoView(size: 60)
                    .opacity(0.08)
                    .offset(
                        x: geometry.size.width * 0.1,
                        y: geometry.size.height * 0.6 + treeAnimation1
                    )
                    .rotationEffect(.degrees(treeAnimation1 * 0.1))
                
                TreeLogoView(size: 40)
                    .opacity(0.06)
                    .offset(
                        x: geometry.size.width * 0.8,
                        y: geometry.size.height * 0.7 + treeAnimation2
                    )
                    .rotationEffect(.degrees(-treeAnimation2 * 0.08))
                
                TreeLogoView(size: 80)
                    .opacity(0.05)
                    .offset(
                        x: geometry.size.width * 0.6,
                        y: geometry.size.height * 0.5 + treeAnimation3
                    )
                    .rotationEffect(.degrees(treeAnimation3 * 0.05))
                
                // Elementos decorativos adicionales - sparkles orgánicos
                ForEach(0..<8, id: \.self) { index in
                    Circle()
                        .fill(Color.babelAccent.opacity(0.3))
                        .frame(width: CGFloat.random(in: 3...8), height: CGFloat.random(in: 3...8))
                        .offset(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height) + sin(sparkleRotation + Double(index)) * 20
                        )
                        .opacity(0.6 + sin(sparkleRotation + Double(index)) * 0.4)
                        .animation(
                            .easeInOut(duration: Double.random(in: 3...5))
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                            value: sparkleRotation
                        )
                }
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header con saludo personalizado y entrada animada
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Bienvenido de vuelta,")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color.babelDark.opacity(0.7))
                                    .opacity(showContent ? 1 : 0)
                                    .offset(y: showContent ? 0 : 20)
                                
                                Text(viewModel.userName)
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color.babelDark)
                                    .opacity(showContent ? 1 : 0)
                                    .offset(y: showContent ? 0 : 30)
                            }
                            
                            Spacer()
                            
                            // Avatar con TreeLogo y breathing animation
                            ZStack {
                                Circle()
                                    .fill(Color.babelAccent.opacity(0.3))
                                    .frame(width: 50, height: 50)
                                    .scaleEffect(breathingScale)
                                
                                TreeLogoView(size: 30)
                                    .scaleEffect(breathingScale * 0.95)
                            }
                            .opacity(showContent ? 1 : 0)
                            .scaleEffect(showContent ? 1 : 0.8)
                        }
                        
                        Text("Tu progreso y bienestar actual")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color.babelDark.opacity(0.6))
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 15)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 60)
                    .padding(.bottom, 32)
                    .animation(.spring(response: 1.2, dampingFraction: 0.8).delay(0.2), value: showContent)
                    
                    // Card principal con mood y reflexión - breathing effect
                    VStack(spacing: 0) {
                        // Daily Mood Log
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Daily Mood Log")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.babelDark)
                                .opacity(showContent ? 1 : 0)
                                .offset(x: showContent ? 0 : -30)
                            
                            // Selector de mood con animaciones más playful
                            HStack(spacing: 16) {
                                ForEach(viewModel.moodOptions, id: \.self) { mood in
                                    Button(action: {
                                        // Haptic feedback
                                        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                                        impactFeedback.impactOccurred()
                                        
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                            selectedMood = mood
                                        }
                                    }) {
                                        VStack(spacing: 8) {
                                            ZStack {
                                                // Forma más orgánica en lugar de círculo perfecto
                                                RoundedRectangle(cornerRadius: 24)
                                                    .fill(selectedMood == mood ? mood.color.opacity(0.3) : Color.gray.opacity(0.1))
                                                    .frame(width: 48, height: 48)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(selectedMood == mood ? mood.color.opacity(0.5) : Color.clear, lineWidth: 2)
                                                    )
                                                
                                                Text(moodEmoji(for: mood))
                                                    .font(.system(size: 24))
                                                    .scaleEffect(selectedMood == mood ? 1.2 : 1.0)
                                                    .rotationEffect(.degrees(selectedMood == mood ? 5 : 0))
                                            }
                                            .scaleEffect(selectedMood == mood ? 1.15 : 1.0)
                                            .animation(.spring(response: 0.4, dampingFraction: 0.5), value: selectedMood)
                                            .shadow(
                                                color: selectedMood == mood ? mood.color.opacity(0.3) : Color.clear,
                                                radius: selectedMood == mood ? 8 : 0,
                                                x: 0,
                                                y: selectedMood == mood ? 4 : 0
                                            )
                                            
                                            Text(mood.label)
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(selectedMood == mood ? Color.babelDark : Color.gray)
                                                .scaleEffect(selectedMood == mood ? 1.05 : 1.0)
                                                .animation(.spring(response: 0.3), value: selectedMood)
                                        }
                                    }
                                    .buttonStyle(BouncyButtonStyle())
                                }
                            }
                            .padding(.horizontal, 8)
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 20)
                        }
                        .padding(.top, 28)
                        .padding(.horizontal, 24)
                        
                        // Daily Reflection Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Daily Reflection")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.babelDark)
                                .opacity(showContent ? 1 : 0)
                                .offset(x: showContent ? 0 : -30)
                            
                            Text("¿Cómo te sientes acerca de tus emociones actuales?")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color.babelDark.opacity(0.7))
                                .opacity(showContent ? 1 : 0)
                                .offset(y: showContent ? 0 : 10)
                            
                            // Campo de reflexión con hover effect
                            Button(action: {
                                let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                                impactFeedback.impactOccurred()
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
                                        .rotationEffect(.degrees(floatingOffset * 0.5))
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16) // Más redondeado
                                        .fill(Color.babelLight.opacity(0.5))
                                        .stroke(Color.babelMedium.opacity(0.3), lineWidth: 1)
                                        .shadow(color: Color.babelPrimary.opacity(0.1), radius: 4)
                                )
                            }
                            .buttonStyle(DelightfulButtonStyle())
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 15)
                        }
                        .padding(.top, 32)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 28)
                        .animation(.spring(response: 1.0, dampingFraction: 0.8).delay(0.4), value: showContent)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 28) // Más redondeado para ser más orgánico
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.babelLight.opacity(0.9),
                                        Color.white.opacity(0.95),
                                        Color.babelMedium.opacity(0.1)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: Color.babelMedium.opacity(0.2), radius: 8, x: 0, y: 4)
                    )

                    .padding(.horizontal, 20)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 30)
                    .animation(.spring(response: 1.2, dampingFraction: 0.8).delay(0.6), value: showContent)
                    
                    // Quick Actions Section con entrada escalonada
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Accesos Rápidos")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.babelDark)
                            .padding(.horizontal, 24)
                            .opacity(showContent ? 1 : 0)
                            .offset(x: showContent ? 0 : -30)
                        
                        HStack(spacing: 12) {
                            QuickActionCard(
                                title: "Chat",
                                subtitle: "Habla con tu compañero emocional",
                                iconName: "message.fill",
                                color: Color.babelSecondary,
                                action: viewModel.openChat
                            )
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 40)
                            .animation(.spring(response: 1.0, dampingFraction: 0.8).delay(0.8), value: showContent)
                            
                            QuickActionCard(
                                title: "Estadísticas",
                                subtitle: "Tu progreso",
                                iconName: "chart.bar.fill",
                                color: Color.babelAccent,
                                action: viewModel.openStats
                            )
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 40)
                            .animation(.spring(response: 1.0, dampingFraction: 0.8).delay(1.0), value: showContent)
                            
                            QuickActionCard(
                                title: "Misiones",
                                subtitle: "Nuevos retos",
                                iconName: "target",
                                color: Color.babelMedium,
                                action: viewModel.openMissions
                            )
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 40)
                            .animation(.spring(response: 1.0, dampingFraction: 0.8).delay(1.2), value: showContent)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 32)
                    .animation(.spring(response: 1.0, dampingFraction: 0.8).delay(0.7), value: showContent)
                    
                    Spacer(minLength: 120) // Espacio para el TabBar
                }
            }
            
            // Tab Bar en la parte inferior
            VStack {
                Spacer()
                TabBarView(selectedTab: $viewModel.selectedTab)
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea(.container, edges: .bottom)
        .sheet(isPresented: $showReflectionInput) {
            ReflectionInputView(reflection: $dailyReflection)
        }
        .onAppear {
            startPlayfulAnimations()
            
            // Entrada de contenido con delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showContent = true
            }
        }
    }
    
    // Función para iniciar animaciones playful
    private func startPlayfulAnimations() {
        // Breathing animation
        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
            breathingScale = 1.05
        }
        
        // Floating offset para elementos
        withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
            floatingOffset = 10
        }
        
        // Sparkle rotation
        withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
            sparkleRotation = 360
        }
        
        // Tree animations con diferentes duraciones para naturalidad
        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            treeAnimation1 = 15
        }
        
        withAnimation(.easeInOut(duration: 5.5).repeatForever(autoreverses: true)) {
            treeAnimation2 = -12
        }
        
        withAnimation(.easeInOut(duration: 6.2).repeatForever(autoreverses: true)) {
            treeAnimation3 = 8
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

// Bouncy Button Style para efectos playful
struct BouncyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// Delightful Button Style para interacciones más ricas
struct DelightfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .offset(y: configuration.isPressed ? 1 : 0)
            .animation(.spring(response: 0.2, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

// Quick Action Card Component mejorado
struct QuickActionCard: View {
    let title: String
    let subtitle: String
    let iconName: String
    let color: Color
    let action: () -> Void
    
    @State private var isHovered = false

    var body: some View {
        Button(action: {
            // Haptic feedback más rico
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
            action()
        }) {
            VStack(spacing: 12) {
                ZStack {
                    // Forma más orgánica para el ícono
                    RoundedRectangle(cornerRadius: 18)
                        .fill(color)
                        .frame(width: 56, height: 56)
                        .shadow(color: color.opacity(0.3), radius: isHovered ? 8 : 4, x: 0, y: isHovered ? 6 : 3)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .scaleEffect(isHovered ? 1.1 : 1.0)
                        .rotationEffect(.degrees(isHovered ? 3 : 0))
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
                RoundedRectangle(cornerRadius: 20) // Más redondeado
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.95),
                                Color.babelLight.opacity(0.8),
                                Color.babelMedium.opacity(0.08)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.babelMedium.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: Color.babelMedium.opacity(0.15), radius: isHovered ? 10 : 6, x: 0, y: isHovered ? 6 : 3)
            )
            .scaleEffect(isHovered ? 1.02 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isHovered)
        }
        .buttonStyle(BouncyButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isHovered = pressing
        }, perform: {})
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
                    Image(systemName: tab.icon)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color.babelDark)
                        .opacity(selectedTab == tab ? 1.0 : 0.4)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 28)
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: 24,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 24
            )
            .fill(Color.white)
            .overlay(
                UnevenRoundedRectangle(
                    topLeadingRadius: 24,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 24
                )
                .stroke(Color.babelMedium.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color.babelMedium.opacity(0.08), radius: 12, x: 0, y: -4)
        )
    }
} 


