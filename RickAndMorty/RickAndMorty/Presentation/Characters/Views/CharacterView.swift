// 
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import SwiftUI

struct CharacterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var scrollOffset: CGFloat = 0.0
    
    @State private var showEpisodes: Bool = false
    
    private let imageHeight: CGFloat = 400.0
    
    let character: Character
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    characterImage
                    characterNameView
                    characterInfoView
                }
//                .offset(y: scrollOffset > 0 ? 0 : scrollOffset)
            }
//            .onScrollGeometryChange(for: CGFloat.self, of: { geometry in
//                geometry.contentOffset.y
//            }, action: { oldValue, newValue in
//                scrollOffset = newValue
//            })
            .background(.black.gradient)
            .toolbar { toolbarContent }
            .ignoresSafeArea()
        }
    }
}

// MARK: - Subviews

private extension CharacterView {
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button(role: .close) {
                dismiss()
            }
        }
    }
    
    var characterImage: some View {
        AsyncImage(url: character.image) { phase in
            switch phase {
            case .empty:
                EmptyView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: imageHeight + (scrollOffset < 0 ? abs(scrollOffset / 2) : 0))
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    var characterInfoView: some View {
        VStack(alignment: .leading) {
            Divider()
                .background(.teal)
                .padding(.horizontal)
            chipsScroll
                .padding(.vertical)
            basicInfoView
                .padding(.horizontal)
            Divider()
                .background(.teal)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                Text("Episodes")
                    .font(.title2)
                    .foregroundStyle(.white)
                DisclosureGroup(isExpanded: $showEpisodes) {
                    Text("Episode")
                } label: {
                    Button {
                        showEpisodes.toggle()
                    } label: {
                        Text("View all episode appearances")
                    }
                }
                .disclosureGroupStyle(.automatic)
                .tint(.white)
            }
            .padding(.horizontal)
        }
    }
    
    var characterNameView: some View {
        Text(character.name)
            .font(.title.bold())
            .foregroundStyle(.white)
    }
    
    var chipsScroll: some View {
        ScrollView(.horizontal) {
            HStack {
                speciesView
                genderView
                typeView
            }
            .offset(x: 16)
        }
    }
    
    var basicInfoView: some View {
        VStack(spacing: 8) {
            CharacterInfoRow(title: "Origin", value: character.origin.name)
            CharacterInfoRow(title: "Current location", value: character.location.name)
        }
    }
    
    var speciesView: some View {
        Text(character.species.capitalized)
            .foregroundStyle(.white)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.green.opacity(0.5))
            .border(.white.opacity(0.3), width: 0.5)
            .clipShape(.capsule)
    }
    
    var genderView: some View {
        Text(character.gender.rawValue.capitalized)
            .foregroundStyle(.white)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.blue.opacity(0.5))
            .border(.white.opacity(0.3), width: 0.5)
            .clipShape(.capsule)
    }
    
    var typeView: some View {
        Text(character.type.isEmpty ? "No type" : character.type.capitalized)
            .foregroundStyle(.white)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.red.opacity(0.5))
            .border(.white.opacity(0.3), width: 0.5)
            .clipShape(.capsule)
    }
}

// MARK: - Previews

#Preview {
    CharacterView(character: Character(
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
    ))
}
