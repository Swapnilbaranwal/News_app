//
//  NewsArticleGridView.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import SwiftUI

struct NewsArticleGridView: View {
    @ObservedObject var viewModel: NewsArticleGridViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVStack {
                    ForEach(viewModel.newsArticles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            NewsArticleGridCellView(article: article)
                        }
                    }
                }
            }
            .navigationTitle("News")
        }
        .onAppear {
            viewModel.fetchNewsArticles()
        }
    }
}

struct NewsArticleGridCellView: View {
    let article: NewsArticle
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: article.imageUrl)!, placeholder: {
                ProgressView()
            })
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
            .aspectRatio(contentMode: .fit)
            
            Text(article.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(nil)
                .padding(.top, 8)
        }
        .padding()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    
    init(url: URL, placeholder: (() -> Placeholder)? = nil) {
        self._loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder?()
    }
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    init(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}


struct NewsArticleGridView_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticleGridView()
    }
}
