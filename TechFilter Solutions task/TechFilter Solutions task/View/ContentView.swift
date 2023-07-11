//
//  ContentView.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.news.isEmpty {
                ProgressView()
                    .onAppear {
                        viewModel.loadNews()
                    }
            } else {
                let columns = [GridItem(.flexible()), GridItem(.flexible())]
                LazyVStack(spacing: 16) {
                    LazyHGrid(rows: columns, spacing: 16) {
                        ForEach(viewModel.news, id: \.self) { news in
                            NavigationLink(destination: NewsDetailView(news: news)) {
                                NewsGridCell(news: news)
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    viewModel.fetchNewsFromCoreData()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
