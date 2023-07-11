//
//  NewGridCell.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import Foundation
import SwiftUI

struct NewsGridCell: View {
    let news: News
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: news.urlToImage) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                @unknown default:
                    fatalError()
                }
            }
            .frame(height: 150)
            
            Text(news.title)
                .font(.headline)
                .lineLimit(nil)
            
            Text(news.description ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(nil)
        }
    }
}
