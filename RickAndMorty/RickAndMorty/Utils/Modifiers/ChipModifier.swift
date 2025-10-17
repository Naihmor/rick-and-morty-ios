// 
//  ChipModifier.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 16/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation
import SwiftUI

struct ChipModifier: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(color.opacity(0.5))
            .border(.white.opacity(0.3), width: 0.5)
            .clipShape(.capsule)
    }
}

extension View {
    
    func chipStyle(color: Color) -> some View {
        modifier(ChipModifier(color: color))
    }
}
