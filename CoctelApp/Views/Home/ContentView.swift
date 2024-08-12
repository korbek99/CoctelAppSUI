//
//  ContentView.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 11-08-24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CoctelViewModel()
    var body: some View {
        TabView {
            ListCoctelView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle")
                }
        }
    }
}

