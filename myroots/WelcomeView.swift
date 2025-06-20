//
//  WelcomeView.swift
//  myroots
//
//  Created by Assistant on 13/06/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showLogin = false
    @State private var showOnboarding = false
    @State private var animateContent = false
    
    var body: some View {
        if showOnboarding {
            OnboardingView()
        } else {
            ZStack {
            // Fondo con gradiente
            LinearGradient(
                colors: [Color.babelLight, Color.white, Color.babelMedium.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header con logo
                VStack(spacing: 20) {
                    TreeLogoView(size: 80)
                        .scaleEffect(animateContent ? 1.0 : 0.8)
                        .opacity(animateContent ? 1.0 : 0)
                    
                    Text("Babel")
                        .font(.system(size: 32, weight: .light, design: .rounded))
                        .foregroundColor(Color.babelDark)
                        .opacity(animateContent ? 1.0 : 0)
                }
                .padding(.top, 60)
                .animation(.easeOut(duration: 1.0).delay(0.3), value: animateContent)
                
                Spacer()
                
                // Contenido principal
                VStack(spacing: 30) {
                    // Avatar/Ilustración amigable
                    ZStack {
                        Circle()
                            .fill(Color.babelAccent.opacity(0.3))
                            .frame(width: 140, height: 140)
                        
                        Circle()
                            .fill(Color.babelSecondary.opacity(0.5))
                            .frame(width: 120, height: 120)
                        
                        // Avatar simple - cara amigable
                        VStack(spacing: 8) {
                            HStack(spacing: 20) {
                                Circle()
                                    .fill(Color.babelDark)
                                    .frame(width: 8, height: 8)
                                Circle()
                                    .fill(Color.babelDark)
                                    .frame(width: 8, height: 8)
                            }
                            
                            // Sonrisa
                            Path { path in
                                path.addArc(
                                    center: CGPoint(x: 0, y: 0),
                                    radius: 15,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(180),
                                    clockwise: false
                                )
                            }
                            .stroke(Color.babelDark, lineWidth: 3)
                            .frame(width: 30, height: 15)
                        }
                    }
                    .scaleEffect(animateContent ? 1.0 : 0.8)
                    .opacity(animateContent ? 1.0 : 0)
                    .animation(.easeOut(duration: 1.0).delay(0.6), value: animateContent)
                    
                    // Texto de bienvenida
                    VStack(spacing: 16) {
                        Text("Bienvenido a Babel")
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.babelDark)
                            .multilineTextAlignment(.center)
                        
                        Text("Tu compañero que te escucha, siempre.")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.babelDark.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                    }
                    .padding(.horizontal, 40)
                    .opacity(animateContent ? 1.0 : 0)
                    .animation(.easeOut(duration: 1.0).delay(0.9), value: animateContent)
                }
                
                Spacer()
                
                // Botones de acción
                VStack(spacing: 16) {
                    // Botón principal
                    Button(action: {
                        showOnboarding = true
                    }) {
                        HStack {
                            Text("Empecemos")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .fill(Color.babelPrimary)
                        )
                    }
                    .scaleEffect(animateContent ? 1.0 : 0.8)
                    .opacity(animateContent ? 1.0 : 0)
                    .animation(.easeOut(duration: 1.0).delay(1.2), value: animateContent)
                    
                    // Botón secundario - Iniciar sesión
                    Button(action: {
                        showLogin = true
                    }) {
                        Text("Ya tengo una cuenta")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.babelDark)
                            .underline()
                    }
                    .opacity(animateContent ? 1.0 : 0)
                    .animation(.easeOut(duration: 1.0).delay(1.4), value: animateContent)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            animateContent = true
        }
        .sheet(isPresented: $showLogin) {
            LoginView()
        }
        }
    }
}

#Preview {
    WelcomeView()
}
