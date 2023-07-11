//
//  NewsDetailView.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import Foundation
import SwiftUI

struct NewsDetailView: View {
    let news: News
    @State private var isShowingWebView = false
    @State private var isShowingImage = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: news.urlToImage) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .clipped()
                            .onTapGesture {
                                isShowingImage = true
                            }
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .clipped()
                    @unknown default:
                        fatalError()
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(news.author ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(news.title)
                        .font(.title)
                        .lineLimit(nil)
                    
                    Text(news.description ?? "")
                        .font(.body)
                        .lineLimit(nil)
                    
                    HStack {
                        Text("Published at: ")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(news.publishedAt, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Button(action: {
                    isShowingWebView = true
                }) {
                    Text("Read more")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .sheet(isPresented: $isShowingWebView) {
                WebView(url: news.url.absoluteString )
            }
            .sheet(isPresented: $isShowingImage) {
                ImageModalView(imageUrl: news.urlToImage?.absoluteString ?? "")
            }
        }
//        .navigationTitle(news.source.name)
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
