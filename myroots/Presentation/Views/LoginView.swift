//
//  LoginView.swift
//  myroots
//
//  Created by Assistant on 13/06/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
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
                            TreeLogoView(size: 60)
                            
                            Text("Bienvenido de vuelta")
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.babelDark)
                            
                            Text("Nos alegra verte otra vez")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color.babelDark.opacity(0.7))
                        }
                        .padding(.top, 20)
                        
                        // Formulario
                        VStack(spacing: 20) {
                            // Campo email
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color.babelDark)
                                
                                TextField("tu@email.com", text: $email)
                                    .textFieldStyle(BabelTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            }
                            
                            // Campo contraseña
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Contraseña")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color.babelDark)
                                
                                SecureField("••••••••", text: $password)
                                    .textFieldStyle(BabelTextFieldStyle())
                            }
                            
                            // Botón de iniciar sesión
                            Button(action: {
                                loginAction()
                            }) {
                                HStack {
                                    if isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .scaleEffect(0.8)
                                    } else {
                                        Text("Iniciar Sesión")
                                            .font(.system(size: 16, weight: .semibold))
                                    }
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.babelPrimary)
                                        .opacity(isFormValid ? 1.0 : 0.6)
                                )
                            }
                            .disabled(!isFormValid || isLoading)
                            .padding(.top, 10)
                            
                            // Enlace olvidé contraseña
                            Button("¿Olvidaste tu contraseña?") {
                                // Acción para recuperar contraseña
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.babelPrimary)
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer(minLength: 20)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cerrar") {
                        dismiss()
                    }
                    .foregroundColor(Color.babelPrimary)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && email.contains("@")
    }
    
    private func loginAction() {
        isLoading = true
        
        // Simular login
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
            dismiss()
        }
    }
}

// Estilo personalizado para los campos de texto
struct BabelTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .stroke(Color.babelMedium.opacity(0.5), lineWidth: 1)
            )
            .font(.system(size: 16))
    }
}

#Preview {
    LoginView()
}
