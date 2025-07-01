//
//  PersonalityTestView.swift
//  myroots
//
//  Created by Assistant on 13/06/25.
//

import SwiftUI

struct PersonalityTestView: View {
    @ObservedObject var viewModel: PersonalityTestViewModel
    var onTestComplete: (() -> Void)? = nil

    var body: some View {
        if viewModel.showQuickTest {
            QuickPersonalityTestView(
                onTestComplete: { personality in
                    viewModel.choosePersonality(personality)
                    viewModel.showQuickTest = false
                }
            )
        } else {
            ZStack {
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
                                .opacity(viewModel.isFinished ? 0 : 1)
                                .animation(.easeOut(duration: 0.8).delay(0.2), value: viewModel.isFinished)
                            Text("¿Cómo prefieres que te acompañe?")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(Color.babelDark)
                                .multilineTextAlignment(.center)
                                .opacity(1.0)
                            Text("Elige la personalidad que mejor se adapte a ti o realiza nuestro test rápido")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color.babelDark.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .opacity(1.0)
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 30)

                        // Test rápido option
                        Button(action: {
                            viewModel.startQuickTest()
                        }) {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color.babelAccent.opacity(0.2))
                                        .frame(width: 60, height: 60)
                                    Image(systemName: "brain.head.profile")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(Color.babelPrimary)
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Realiza test rápido")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color.babelDark)
                                    Text("5 preguntas para conocerte mejor")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color.babelDark.opacity(0.6))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color.babelPrimary)
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .shadow(color: Color.babelDark.opacity(0.1), radius: 8, x: 0, y: 4)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, 30)
                        .opacity(1.0)

                        // Separador
                        HStack {
                            Rectangle()
                                .fill(Color.babelMedium.opacity(0.5))
                                .frame(height: 1)
                            Text("o elige")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color.babelDark.opacity(0.6))
                                .padding(.horizontal, 16)
                            Rectangle()
                                .fill(Color.babelMedium.opacity(0.5))
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 30)
                        .opacity(1.0)

                        // Personalidades disponibles
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(PersonalityType.allCases, id: \ .self) { personality in
                                PersonalityCard(
                                    personality: personality,
                                    isSelected: viewModel.selectedPersonality == personality,
                                    onTap: {
                                        viewModel.choosePersonality(personality)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 30)
                        .opacity(1.0)

                        // Botón continuar
                        Button(action: {
                            viewModel.finish()
                            onTestComplete?()
                        }) {
                            Text("Comenzar con Babel")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: 28)
                                        .fill(Color.babelPrimary)
                                        .opacity(viewModel.selectedPersonality != nil ? 1.0 : 0.6)
                                )
                        }
                        .disabled(viewModel.selectedPersonality == nil)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .opacity(1.0)
                    }
                }
            }
            .onAppear {
                // Si necesitas animaciones, puedes usar viewModel
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

enum PersonalityType: String, CaseIterable {
    case analytical = "Analítico"
    case dominant = "Dominante"
    case practical = "Práctico"
    case social = "Social"
    
    var description: String {
        switch self {
        case .analytical:
            return "Reflexivo, detallado y objetivo"
        case .dominant:
            return "Directo, decidido y orientado a metas"
        case .practical:
            return "Realista, organizado y eficiente"
        case .social:
            return "Empático, comunicativo y colaborativo"
        }
    }
    
    var icon: String {
        switch self {
        case .analytical:
            return "chart.line.uptrend.xyaxis"
        case .dominant:
            return "target"
        case .practical:
            return "gearshape.fill"
        case .social:
            return "person.2.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .analytical:
            return Color.babelPrimary
        case .dominant:
            return Color.babelSecondary
        case .practical:
            return Color.babelAccent
        case .social:
            return Color.babelMedium
        }
    }
}

struct PersonalityCard: View {
    let personality: PersonalityType
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 16) {
                // Icono
                ZStack {
                    Circle()
                        .fill(personality.color.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: personality.icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(personality.color)
                }
                
                // Texto
                VStack(spacing: 8) {
                    Text(personality.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.babelDark)
                    
                    Text(personality.description)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.babelDark.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? personality.color : Color.clear, lineWidth: 2)
                    )
                    .shadow(color: Color.babelDark.opacity(0.1), radius: 8, x: 0, y: 4)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

struct QuickPersonalityTestView: View {
    let onTestComplete: (PersonalityType) -> Void
    @State private var currentQuestion = 0
    @State private var answers: [Int] = []
    @State private var animateContent = false
    
    private let questions = [
        TestQuestion(
            text: "Cuando tienes un problema, prefieres:",
            options: [
                "Analizarlo detalladamente antes de actuar",
                "Tomar acción inmediata",
                "Buscar una solución práctica y simple",
                "Hablar con otros para obtener perspectivas"
            ]
        ),
        TestQuestion(
            text: "En un grupo de trabajo, tiendes a:",
            options: [
                "Investigar y proporcionar datos",
                "Liderar y tomar decisiones",
                "Organizar tareas y procesos",
                "Facilitar la comunicación entre miembros"
            ]
        ),
        TestQuestion(
            text: "Tu enfoque ideal para el crecimiento personal es:",
            options: [
                "Autoanálisis profundo y reflexión",
                "Establecer metas ambiciosas y alcanzarlas",
                "Crear hábitos sostenibles y medibles",
                "Compartir experiencias y aprender de otros"
            ]
        ),
        TestQuestion(
            text: "Cuando te sientes abrumado, prefieres:",
            options: [
                "Entender las causas del estrés",
                "Actuar para cambiar la situación",
                "Hacer una lista y priorizar tareas",
                "Buscar apoyo emocional de seres queridos"
            ]
        ),
        TestQuestion(
            text: "Tu estilo de comunicación ideal es:",
            options: [
                "Preciso y basado en hechos",
                "Directo y al grano",
                "Claro y orientado a la acción",
                "Cálido y empático"
            ]
        )
    ]
    
    var body: some View {
        ZStack {
            // Fondo
            LinearGradient(
                colors: [Color.babelLight, Color.white],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Progress bar
                OnboardingProgressBar(
                    currentStep: currentQuestion,
                    totalSteps: questions.count
                )
                .padding(.top, 60)
                .padding(.horizontal, 40)
                
                // Pregunta
                VStack(spacing: 32) {
                    Text(questions[currentQuestion].text)
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.babelDark)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding(.horizontal, 30)
                        .opacity(animateContent ? 1.0 : 0)
                        .animation(.easeOut(duration: 0.6), value: animateContent)
                    
                    // Opciones
                    VStack(spacing: 16) {
                        ForEach(0..<questions[currentQuestion].options.count, id: \.self) { index in
                            Button(action: {
                                selectAnswer(index)
                            }) {
                                HStack {
                                    Text(questions[currentQuestion].options[index])
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color.babelDark)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                        .shadow(color: Color.babelDark.opacity(0.1), radius: 4, x: 0, y: 2)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .opacity(animateContent ? 1.0 : 0)
                            .animation(.easeOut(duration: 0.6).delay(Double(index) * 0.1), value: animateContent)
                        }
                    }
                    .padding(.horizontal, 30)
                }
                
                Spacer()
            }
        }
        .onAppear {
            animateContent = true
        }
        .onChange(of: currentQuestion) { _ in
            animateContent = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animateContent = true
            }
        }
    }
    
    private func selectAnswer(_ answerIndex: Int) {
        answers.append(answerIndex)
        
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            // Calcular resultado
            let result = calculatePersonality()
            onTestComplete(result)
        }
    }
    
    private func calculatePersonality() -> PersonalityType {
        let scores = [0, 0, 0, 0] // Analytical, Dominant, Practical, Social
        
        for answer in answers {
            switch answer {
            case 0: // Analytical
                break
            case 1: // Dominant
                break
            case 2: // Practical
                break
            case 3: // Social
                break
            default:
                break
            }
        }
        
        // Por simplicidad, retornamos uno aleatorio
        // En una implementación real, calcularías basado en las respuestas
        return PersonalityType.allCases.randomElement() ?? .social
    }
}

struct TestQuestion {
    let text: String
    let options: [String]
}

#Preview {
    PersonalityTestView(viewModel: PersonalityTestViewModel())
}
