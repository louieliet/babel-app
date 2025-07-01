import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            // Fondo degradado suave
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemTeal).opacity(0.1), Color(.systemYellow).opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                // Saludo y avatar
                HStack {
                    VStack(alignment: .leading) {
                        Text("¡Hola, \(viewModel.userName)!")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("¿Cómo te sientes hoy?")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .foregroundColor(.accentColor)
                }
                .padding(.horizontal)

                // Estado de ánimo
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.moodOptions, id: \.self) { mood in
                            VStack {
                                Image(systemName: mood.icon)
                                    .font(.system(size: 28))
                                    .padding()
                                    .background(mood.color.opacity(0.2))
                                    .clipShape(Circle())
                                Text(mood.label)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Accesos rápidos
                HStack(spacing: 16) {
                    HomeQuickLink(
                        title: "Chat",
                        subtitle: "Habla con tu compañero emocional",
                        iconName: "message.fill",
                        color: .blue,
                        action: viewModel.openChat
                    )
                    HomeQuickLink(
                        title: "Estadísticas",
                        subtitle: "Tu progreso",
                        iconName: "chart.bar.fill",
                        color: .green,
                        action: viewModel.openStats
                    )
                    HomeQuickLink(
                        title: "Misiones",
                        subtitle: "Nuevos retos",
                        iconName: "flag.fill",
                        color: .orange,
                        action: viewModel.openMissions
                    )
                }
                .padding(.horizontal)

                // Progreso semanal
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tu ánimo esta semana")
                        .font(.headline)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(radius: 2)
                        VStack {
                            Text("82%")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                            Text("¡Te has sentido bien esta semana!")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    .frame(height: 120)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 32)

            // Menú inferior
            VStack {
                Spacer()
                TabBarView(selectedTab: $viewModel.selectedTab)
            }
        }
    }
}

struct HomeQuickLink: View {
    let title: String
    let subtitle: String
    let iconName: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: iconName)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .padding()
                    .background(color)
                    .clipShape(Circle())
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 100)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .shadow(radius: 2)
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
                            .foregroundColor(selectedTab == tab ? .accentColor : .gray)
                        Text(tab.rawValue)
                            .font(.caption2)
                            .foregroundColor(selectedTab == tab ? .accentColor : .gray)
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
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.07), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal, 24)
    }
} 


