// 
//  CharacterCard.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import SwiftUI

struct CharacterCard: View {
    
    let character: Character
    
    var body: some View {
        AsyncImage(url: character.image) { phase in
            switch phase {
            case .empty:
                emptyCard
            case .success(let image):
                loadedCard(with: image)
            case .failure:
                failedCard
            @unknown default:
                EmptyView()
            }
        }
    }
}

// MARK: - Subviews

private extension CharacterCard {
    
    var emptyCard: some View {
        ZStack {
            Rectangle().opacity(0.08)
            ProgressView()
        }
        .frame(height: 360)
        .clipShape(.containerRelative)
    }
    
    func loadedCard(with image: Image) -> some View {
        ZStack(alignment: .bottom) {
            image
                .resizable()
                .scaledToFit()
                .blurOverlay {
                    Text(character.name.capitalized)
                        .font(.default.bold())
                        .foregroundStyle(.black)
                        .shadow(color: .teal, radius: 3)
                        .lineLimit(1)
                        .padding()
                }
        }
        .clipShape(.containerRelative)
        .shadow(color: .teal.opacity(0.2), radius: 16)
    }
    
    var failedCard: some View {
        ZStack {
            Rectangle().opacity(0.08)
            Image(systemName: "exclamationmark.triangle")
        }
        .frame(height: 160)
        .clipShape(.containerRelative)
    }
}

// MARK: - Previews

#Preview {
    CharacterCard(character: Character.mock)
        .padding()
}
