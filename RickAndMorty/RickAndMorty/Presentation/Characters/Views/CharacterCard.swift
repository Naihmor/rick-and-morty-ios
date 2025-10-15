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
    
    @ViewBuilder
    var emptyCard: some View {
        ZStack {
            Rectangle().opacity(0.08)
            ProgressView()
        }
        .frame(height: 360)
        .clipShape(.containerRelative)
    }
    
    @ViewBuilder
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
    CharacterCard(
        character: Character(
            id: 2,
            name: "Morty Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .init(name: "Earth", url: URL(string: "https://rickandmortyapi.com/api/location/1")!),
            location: .init(name: "Earth", url: URL(string: "https://rickandmortyapi.com/api/location/20")!),
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!,
            episode: [URL(string: "https://rickandmortyapi.com/api/episode/1")],
            url: URL(string: "https://rickandmortyapi.com/api/character/2")!,
            created: .now
        )
    )
    .padding()
}
