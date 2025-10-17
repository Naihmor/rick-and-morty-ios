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
    
    @State private var viewModel: CharacterViewModel
    
    private let imageHeight: CGFloat = 400.0
    
    init(viewModel: CharacterViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                imageSection
                nameandChipsSection
                originAndLocationSection
                episodesSection
            }
            .toolbar { toolbarContent }
            .ignoresSafeArea()
        }
    }
}

// MARK: - Subviews

private extension CharacterView {
    
    var imageSection: some View {
        Section {
            characterImage
        }
        .listRowInsets(.all, 0)
        .listSectionMargins(.all, 0)
        .listSectionSeparator(.hidden)
        .listSectionSpacing(64)
    }
    
    var nameandChipsSection: some View {
        Section {
            characterNameView
            chipsScroll
                .listRowInsets(.all, 0)
        }
    }
    
    var originAndLocationSection: some View {
        Section {
            originAndLocationView
        }
    }
    
    var episodesSection: some View {
        Section("Episodes") {
            DisclosureGroup(isExpanded: $viewModel.isEpisodesExpanded) {
                if viewModel.isLoadingEpisodes {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if let message = viewModel.episodesErrorMessage {
                    VStack(spacing: 8) {
                        Text(message)
                            .foregroundStyle(.secondary)
                        Button("Retry") {
                            viewModel.reloadEpisodes()
                        }
                    }
                } else if viewModel.episodes.isEmpty {
                    Text("No episodes to show")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(viewModel.episodes) { episode in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(episode.name)
                            Text("\(episode.episode) - \(episode.airDate)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            } label: {
                Button {
                    viewModel.onTapViewAllEpisodes()
                } label: {
                    Text("View all episode appearances")
                }
            }
            .disclosureGroupStyle(.automatic)
            .tint(.teal)
        }
    }
    
    var characterImage: some View {
        AsyncImage(url: viewModel.character.image) { phase in
            switch phase {
            case .empty:
                EmptyView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    var characterNameView: some View {
        Text(viewModel.character.name)
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
    
    var originAndLocationView: some View {
        VStack(spacing: 8) {
            CharacterInfoRow(title: "Origin", value: viewModel.character.origin.name)
            CharacterInfoRow(title: "Current location", value: viewModel.character.location.name)
        }
    }
    
    var speciesView: some View {
        Text(viewModel.character.species.capitalized)
            .chipStyle(color: .green)
    }
    
    var genderView: some View {
        Text(viewModel.character.gender.rawValue.capitalized)
            .chipStyle(color: .blue)
    }
    
    var typeView: some View {
        Text(viewModel.character.type.isEmpty ? "No type" : viewModel.character.type.capitalized)
            .chipStyle(color: .red)
    }
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button(role: .close) {
                dismiss()
            }
        }
    }
}

// MARK: - Previews

//#Preview {
//    // Lightweight stub for previews
//    struct EpisodesRepositoryStub: EpisodesRepositoryProtocol {
//        func getEpisodes(by ids: [Int]) async throws -> [Episode] { [] }
//    }
//    let repo = EpisodesRepositoryStub()
//    let useCase = GetEpisodesByCharacterUseCase(repository: repo)
//    let useCases = EpisodeUseCases(getEpisodesByCharacter: useCase)
//    let vm = CharacterViewModel(character: Character.mock, useCases: useCases)
//    return CharacterView(character: Character.mock, viewModel: vm)
//}

