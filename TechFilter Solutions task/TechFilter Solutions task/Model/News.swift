//
//  News.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import Foundation
import CoreData
import SwiftUI
import WebKit

struct News: Decodable, Equatable, Identifiable ,Hashable {
    let id: UUID
    let title: String
    let author: String?
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case title, author, description, url, urlToImage, publishedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        title = try container.decode(String.self, forKey: .title)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = try container.decode(URL.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(URL.self, forKey: .urlToImage)
        
        let dateString = try container.decode(String.self, forKey: .publishedAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        publishedAt = dateFormatter.date(from: dateString)!
    }
}

struct NewsResponse: Decodable {
    let articles: [News]
}
struct NewsGridView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.news) { news in
                    NavigationLink(destination: NewsDetailView(news: news)) {
                        NewsGridCell(news: news)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("News")
//        .onAppear {
//            viewModel.loadNews()
//        }
    }
}



struct WebViewWrapper: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
