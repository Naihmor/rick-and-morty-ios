// 
//  RootView.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import SwiftUI

struct RootView: View {
    var body: some View {
		NavigationStack {
			VStack(spacing: 16) {
				Text("Rick & Morty")
					.font(.largeTitle).bold()
				Text("SwiftUI · CLEAN · SOLID · MVVM · iOS 17+")
					.multilineTextAlignment(.center)
					.font(.subheadline)
					.foregroundStyle(.secondary)
			}
			.padding()
			.navigationTitle("Home")
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}

// MARK: - Previews

#Preview {
    RootView()
}
