// 
//  CharacterInfoRow.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import SwiftUI

struct CharacterInfoRow: View {
    
    let title: String
    
    let value: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .font(.title2)
                .foregroundStyle(.gray)
            Text(value.capitalized)
                .font(.title2.bold())
                .foregroundStyle(.white)
            Spacer()
        }
    }
}

// MARK: - Previews

#Preview {
    CharacterInfoRow(title: "Origin", value: "Earth")
}
