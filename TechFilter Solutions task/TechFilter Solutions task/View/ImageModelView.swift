//
//  ImageModelView.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import Foundation
import SwiftUI

struct ImageModalView: View {
    let imageUrl: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                @unknown default:
                    fatalError()
                }
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}
struct ImageModalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
