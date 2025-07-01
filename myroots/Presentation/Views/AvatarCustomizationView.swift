//
//  AvatarCustomizationView.swift
//  myroots
//
//  Created by Assistant on 13/06/25.
//

import SwiftUI

struct AvatarCustomizationView: View {
    @ObservedObject var viewModel: AvatarCustomizationViewModel
    @State private var animateContent = false
    var onContinue: (() -> Void)? = nil
    
    private let skinTones = [
        Color(hex: "#F5C6A0"), Color(hex: "#E8B07F"), Color(hex: "#D4985D"),
        Color(hex: "#C08553"), Color(hex: "#A67448"), Color(hex: "#8B5A3C")
    ]
    
    private let hairStyles = ["curly.hair", "straight.hair", "short.hair", "long.hair"]
    private let accessories = ["eyeglasses", "sunglasses", "none", "hat"]
    
    var body: some View {
        ZStack {
            // Fondo
            LinearGradient(
                colors: [Color.babelLight, Color.white],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 16) {
                        TreeLogoView(size: 50)
                            .opacity(animateContent ? 1.0 : 0)
                            .animation(.easeOut(duration: 0.8).delay(0.2), value: animateContent)
                        
                        Text("Conoce a tu compañero")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundColor(Color.babelDark)
                            .opacity(animateContent ? 1.0 : 0)
                            .animation(.easeOut(duration: 0.8).delay(0.4), value: animateContent)
                        
                        Text("Personaliza la apariencia y el nombre de tu asistente emocional")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color.babelDark.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .opacity(animateContent ? 1.0 : 0)
                            .animation(.easeOut(duration: 0.8).delay(0.6), value: animateContent)
                    }
                    .padding(.top, 20)
                    
                    // Avatar preview
                    VStack(spacing: 20) {
                        CustomAvatarView(
                            skinTone: skinTones[viewModel.selectedSkinToneIndex],
                            hairStyle: viewModel.selectedHairStyleIndex,
                            accessory: viewModel.selectedAccessoryIndex
                        )
                        .scaleEffect(animateContent ? 1.0 : 0.8)
                        .opacity(animateContent ? 1.0 : 0)
                        .animation(.easeOut(duration: 0.8).delay(0.8), value: animateContent)
                        
                        // Campo nombre
                        VStack(alignment: .leading, spacing: 8) {
                            Text("¿Cómo quieres llamar a tu compañero?")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.babelDark)
                            
                            TextField("Ej: Alex, Sam, Charlie...", text: $viewModel.avatarName)
                                .textFieldStyle(BabelTextFieldStyle())
                        }
                        .padding(.horizontal, 30)
                        .opacity(animateContent ? 1.0 : 0)
                        .animation(.easeOut(duration: 0.8).delay(1.0), value: animateContent)
                    }
                    
                    // Personalización
                    VStack(spacing: 24) {
                        // Tono de piel
                        CustomizationSection(
                            title: "Tono de piel",
                            items: skinTones.enumerated().map { index, color in
                                CustomizationItem(
                                    id: index,
                                    view: AnyView(
                                        Circle()
                                            .fill(color)
                                            .frame(width: 40, height: 40)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.babelPrimary, lineWidth: viewModel.selectedSkinToneIndex == index ? 3 : 0)
                                            )
                                    )
                                )
                            },
                            selectedIndex: $viewModel.selectedSkinToneIndex
                        )
                        
                        // Estilo de cabello
                        CustomizationSection(
                            title: "Estilo de cabello",
                            items: hairStyles.enumerated().map { index, style in
                                CustomizationItem(
                                    id: index,
                                    view: AnyView(
                                        ZStack {
                                            Circle()
                                                .fill(Color.babelMedium.opacity(0.3))
                                                .frame(width: 50, height: 50)
                                            
                                            Image(systemName: "person.crop.circle")
                                                .font(.system(size: 24))
                                                .foregroundColor(Color.babelDark)
                                        }
                                        .overlay(
                                            Circle()
                                                .stroke(Color.babelPrimary, lineWidth: viewModel.selectedHairStyleIndex == index ? 3 : 0)
                                        )
                                    )
                                )
                            },
                            selectedIndex: $viewModel.selectedHairStyleIndex
                        )
                        
                        // Accesorios
                        CustomizationSection(
                            title: "Accesorios",
                            items: accessories.enumerated().map { index, accessory in
                                CustomizationItem(
                                    id: index,
                                    view: AnyView(
                                        ZStack {
                                            Circle()
                                                .fill(Color.babelAccent.opacity(0.3))
                                                .frame(width: 50, height: 50)
                                            
                                            if accessory != "none" {
                                                Image(systemName: accessory)
                                                    .font(.system(size: 20))
                                                    .foregroundColor(Color.babelDark)
                                            } else {
                                                Text("Sin")
                                                    .font(.system(size: 12, weight: .medium))
                                                    .foregroundColor(Color.babelDark)
                                            }
                                        }
                                        .overlay(
                                            Circle()
                                                .stroke(Color.babelPrimary, lineWidth: viewModel.selectedAccessoryIndex == index ? 3 : 0)
                                        )
                                    )
                                )
                            },
                            selectedIndex: $viewModel.selectedAccessoryIndex
                        )
                    }
                    .padding(.horizontal, 30)
                    .opacity(animateContent ? 1.0 : 0)
                    .animation(.easeOut(duration: 0.8).delay(1.2), value: animateContent)
                    
                    // Botón continuar
                    Button(action: {
                        onContinue?()
                    }) {
                        HStack {
                            Text("Continuar")
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
                                .opacity(viewModel.isFormValid ? 1.0 : 0.6)
                        )
                    }
                    .disabled(!viewModel.isFormValid)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    .opacity(animateContent ? 1.0 : 0)
                    .animation(.easeOut(duration: 0.8).delay(1.4), value: animateContent)
                }
            }
        }
        .onAppear {
            animateContent = true
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CustomAvatarView: View {
    let skinTone: Color
    let hairStyle: Int
    let accessory: Int
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Fondo del avatar
            Circle()
                .fill(Color.babelAccent.opacity(0.1))
                .frame(width: 140, height: 140)
            
            // Cara
            Circle()
                .fill(skinTone)
                .frame(width: 100, height: 100)
            
            // Características faciales
            VStack(spacing: 8) {
                // Ojos
                HStack(spacing: 16) {
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
                        radius: 12,
                        startAngle: .degrees(0),
                        endAngle: .degrees(180),
                        clockwise: false
                    )
                }
                .stroke(Color.babelDark, lineWidth: 2)
                .frame(width: 24, height: 12)
            }
            .offset(y: -5)
            
            // Animación de pulso sutil
            Circle()
                .stroke(Color.babelPrimary.opacity(0.3), lineWidth: 2)
                .frame(width: isAnimating ? 150 : 140)
                .opacity(isAnimating ? 0 : 0.5)
                .animation(.easeInOut(duration: 2.0).repeatForever(), value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct CustomizationItem {
    let id: Int
    let view: AnyView
}

struct CustomizationSection: View {
    let title: String
    let items: [CustomizationItem]
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color.babelDark)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(items, id: \.id) { item in
                        Button(action: {
                            selectedIndex = item.id
                        }) {
                            item.view
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 1)
            }
        }
    }
}

#Preview {
    AvatarCustomizationView(viewModel: AvatarCustomizationViewModel())
}
