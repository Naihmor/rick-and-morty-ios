// 
//  BlurOverlay.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation
import SwiftUI

public extension View {
    
    func blurOverlay<Overlay: View>(@ViewBuilder overlay: @escaping () -> Overlay) -> some View {
        modifier(BlurOverlay(overlay: overlay))
    }
}

private struct BlurOverlay<Overlay: View>: ViewModifier {
    
    let overlay: () -> Overlay
    
    @State private var height: CGFloat = 16
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
                .overlay {
                    content
                        .allowsHitTesting(false)
                        .blur(radius: 16)
                        .scaleEffect(16)
                        .mask {
                            VStack {
                                Spacer()
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        .black.opacity(0.1),
                                        .black.opacity(0.7),
                                        .black.opacity(0.9),
                                        .black,
                                        .black,
                                        .black,
                                        .black
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: height + 16)
                            }
                        }
                }
            overlay()
                .onGeometryChange(for: CGSize.self) { geometry in
                    geometry.size
                } action: { newValue in
                    height += newValue.height
                }
        }
    }
}

#Preview {
    Rectangle()
        .fill(.black.opacity(0.1))
        .blurOverlay {
            Text("Simple overlay")
                .font(.callout)
                .padding()
        }
}
