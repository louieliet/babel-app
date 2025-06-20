//
//  TreeLogoView.swift
//  myroots
//
//  Created by Assistant on 13/06/25.
//

import SwiftUI

struct TreeLogoView: View {
    var size: CGFloat = 60
    
    var body: some View {
        ZStack {
            // Tronco
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.babelDark)
                .frame(width: size * 0.15, height: size * 0.3)
                .offset(y: size * 0.25)
            
            // Copa del árbol - círculos superpuestos para crear forma orgánica
            ZStack {
                // Círculo principal
                Circle()
                    .fill(Color.babelAccent)
                    .frame(width: size * 0.7, height: size * 0.7)
                
                // Círculos adicionales para dar textura
                Circle()
                    .fill(Color.babelSecondary)
                    .frame(width: size * 0.5, height: size * 0.5)
                    .offset(x: -size * 0.1, y: -size * 0.1)
                
                Circle()
                    .fill(Color.babelMedium)
                    .frame(width: size * 0.4, height: size * 0.4)
                    .offset(x: size * 0.15, y: size * 0.05)
                
                // Líneas internas para dar textura de hojas
                Path { path in
                    let center = CGPoint(x: 0, y: 0)
                    let radius = size * 0.2
                    
                    // Líneas radiales suaves
                    for i in 0..<8 {
                        let angle = Double(i) * .pi / 4
                        let startX = center.x + cos(angle) * radius * 0.3
                        let startY = center.y + sin(angle) * radius * 0.3
                        let endX = center.x + cos(angle) * radius
                        let endY = center.y + sin(angle) * radius
                        
                        path.move(to: CGPoint(x: startX, y: startY))
                        path.addLine(to: CGPoint(x: endX, y: endY))
                    }
                }
                .stroke(Color.babelDark.opacity(0.3), lineWidth: 1)
            }
            .offset(y: -size * 0.1)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    VStack(spacing: 20) {
        TreeLogoView(size: 40)
        TreeLogoView(size: 60)
        TreeLogoView(size: 100)
    }
    .padding()
    .background(Color.babelLight)
}
