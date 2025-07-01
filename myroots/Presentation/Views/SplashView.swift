//
//  SplashView.swift
//  myroots
//
//  Created by Assistant on 13/06/25.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            // Fondo con gradiente suave
            LinearGradient(
                colors: [Color.babelLight, Color.white],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Logo del árbol
                TreeLogoView(size: 120)
                    .scaleEffect(isAnimating ? 1.0 : 0.8)
                    .opacity(isAnimating ? 1.0 : 0.8)
                    .animation(
                        .easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                
                Spacer()
                
                // Barra de progreso (opcional)
                VStack(spacing: 8) {
                    Text("Cargando...")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.babelDark)
                        .opacity(0.7)
                    
                    // Barra de progreso simple
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.babelMedium.opacity(0.3))
                        .frame(height: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.babelPrimary)
                                .frame(height: 4)
                                .scaleEffect(x: isAnimating ? 1.0 : 0.3, anchor: .leading)
                                .animation(
                                    .easeInOut(duration: 2.0),
                                    value: isAnimating
                                )
                        )
                }
                .padding(.horizontal, 80)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel())
}
