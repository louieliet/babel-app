//
//  OnboardingView.swift
//  myroots
//
//  Created by Assistant on 13/06/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @State private var showAvatarCustomization = false
    
    private let onboardingSteps = [
        OnboardingStep(
            title: "Mereces estar bien",
            subtitle: "Tu bienestar emocional es importante y mereces cuidarlo cada día",
            icon: "heart.fill",
            color: Color.babelSecondary
        ),
        OnboardingStep(
            title: "Aquí podrás hablar sin juicios",
            subtitle: "Este es un espacio seguro donde puedes expresarte libremente",
            icon: "message.circle.fill",
            color: Color.babelAccent
        ),
        OnboardingStep(
            title: "Crecemos juntos",
            subtitle: "Tu compañero Babel aprenderá contigo para ofrecerte el mejor apoyo",
            icon: "leaf.fill",
            color: Color.babelPrimary
        )
    ]
    
    var body: some View {
        if showAvatarCustomization {
            AvatarCustomizationView()
        } else {
            ZStack {
                // Fondo con gradiente
                LinearGradient(
                    colors: [Color.babelLight, Color.white, Color.babelMedium.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Barra de progreso
                    OnboardingProgressBar(
                        currentStep: currentStep,
                        totalSteps: onboardingSteps.count
                    )
                    .padding(.top, 60)
                    .padding(.horizontal, 40)
                    
                    // Contenido principal
                    TabView(selection: $currentStep) {
                        ForEach(0..<onboardingSteps.count, id: \.self) { index in
                            OnboardingStepView(step: onboardingSteps[index])
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .animation(.easeInOut(duration: 0.5), value: currentStep)
                    
                    // Botones de navegación
                    VStack(spacing: 16) {
                        // Botón principal
                        Button(action: {
                            nextStep()
                        }) {
                            Text(currentStep == onboardingSteps.count - 1 ? "Comenzar" : "Continuar")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: 28)
                                        .fill(Color.babelPrimary)
                                )
                        }
                        
                        // Botón saltar (solo en los primeros pasos)
                        if currentStep < onboardingSteps.count - 1 {
                            Button("Saltar") {
                                showAvatarCustomization = true
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.babelDark.opacity(0.6))
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                }
            }
        }
    }
    
    private func nextStep() {
        if currentStep < onboardingSteps.count - 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentStep += 1
            }
        } else {
            showAvatarCustomization = true
        }
    }
}

struct OnboardingStep {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
}

struct OnboardingStepView: View {
    let step: OnboardingStep
    @State private var animateContent = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Icono animado
            ZStack {
                Circle()
                    .fill(step.color.opacity(0.2))
                    .frame(width: 160, height: 160)
                
                Circle()
                    .fill(step.color.opacity(0.4))
                    .frame(width: 120, height: 120)
                
                Image(systemName: step.icon)
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(step.color)
            }
            .scaleEffect(animateContent ? 1.0 : 0.8)
            .opacity(animateContent ? 1.0 : 0)
            .animation(.easeOut(duration: 0.8).delay(0.2), value: animateContent)
            
            // Texto
            VStack(spacing: 20) {
                Text(step.title)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color.babelDark)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                Text(step.subtitle)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color.babelDark.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .lineSpacing(4)
            }
            .padding(.horizontal, 40)
            .opacity(animateContent ? 1.0 : 0)
            .offset(y: animateContent ? 0 : 20)
            .animation(.easeOut(duration: 0.8).delay(0.4), value: animateContent)
            
            Spacer()
        }
        .onAppear {
            animateContent = true
        }
        .onDisappear {
            animateContent = false
        }
    }
}

struct OnboardingProgressBar: View {
    let currentStep: Int
    let totalSteps: Int
    
    var progress: Double {
        Double(currentStep + 1) / Double(totalSteps)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Paso \(currentStep + 1) de \(totalSteps)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.babelDark.opacity(0.6))
                
                Spacer()
                
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.babelPrimary)
            }
            
            // Barra de progreso
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.babelMedium.opacity(0.3))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.babelPrimary)
                        .frame(width: geometry.size.width * progress, height: 8)
                        .animation(.easeInOut(duration: 0.5), value: progress)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    OnboardingView()
}
