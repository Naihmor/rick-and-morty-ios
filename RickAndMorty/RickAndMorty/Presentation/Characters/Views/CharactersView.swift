// 
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import SwiftUI

struct CharactersView: View {
    
    @State private var viewModel: CharactersViewModel
    
    @State private var showFilters: Bool = false
    
    private var columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]
    
    init(viewModel: CharactersViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .error(let error):
                    errorView(error)
                case .loaded:
                    charactersGrid
                case .loading:
                    loadingView
                }
            }
            .background(.black.gradient)
            .navigationTitle("Rick and Morty")
            .navigationSubtitle("All characters and more (burp) from the TV show.")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
            .task { await viewModel.load() }
            .refreshable { await viewModel.refresh() }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer)
        }
    }
}

// MARK: - Subviews

private extension CharactersView {
    
    @ViewBuilder
    func errorView(_ error: String) -> some View {
        ContentUnavailableView {
            Text(error)
        } description: {
            Text("")
        } actions: {
            Button {
                Task { await viewModel.load() }
            } label: {
                Text("Retry")
                    .padding(8)
            }
            .buttonStyle(.glassProminent)
        }
    }
    
    @ViewBuilder
    var charactersGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.filtered, id: \.id) { character in
                    CharacterCard(character: character)
                }
            }
            .padding(16)
        }
    }
    
    @ViewBuilder
    var loadingView: some View {
        ProgressView("Loading...")
            .progressViewStyle(.circular)
    }
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                showFilters = true
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
            }
        }
    }
}

// MARK: - Previews

#Preview {
    CharactersViewBuilder.makeList()
}
