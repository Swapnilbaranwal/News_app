//
//  WebView.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import Foundation
import SwiftUI

struct WebView: View {
    let url: String
    
    var body: some View {
        WebViewWrapper(url: url)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
