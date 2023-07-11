//
//  NewsArticleDetailView.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import SwiftUI


struct ArticleDetailView: View {
    let article: Article
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: article.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            
            Text(article.title)
                .font(.title)
                .foregroundColor(.primary)
                .padding(.top, 16)
            
            Text("By \(article.author) | \(article.publishedDate, formatter: dateFormatter)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding()
            
            Text(article.description)
                .font(.body)
                .padding()
            
            HStack {
                Spacer()
                
                Button(action: {
                    guard let url = URL(string: article.url) else { return }
                    UIApplication.shared.open(url)
                }) {
                    Text("Read more")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding(.top, 16)
        }
        .navigationBarTitle(Text(article.title), displayMode: .inline)
    }
}


struct NewsArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticleDetailView()
    }
}
