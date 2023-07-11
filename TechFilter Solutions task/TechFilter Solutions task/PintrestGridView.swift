//
//  PintrestGridView.swift
//  TechFilter Solutions task
//
//  Created by Swapnil baranwal on 12/04/23.
//

import SwiftUI

//struct GridItem : Identifiable{
//    let id = UUID()
//    let height:CGFloat
//    let title: String
//}
//
//struct PintrestGridView: View {
//    
//    struct Column{
//        let id = UUID()
//        var gridItems = [GridItem]()
//    }
//    let columns = [
//        Column(gridItems: [
//            GridItem(height: 200,title:"1"),
//            GridItem(height: 100,title:"1"),
//            GridItem(height: 130,title:"1"),
//            GridItem(height: 180,title:"1"),
//                           ]),
//        Column(gridItems: [
//            GridItem(height: 200,title:"1"),
//            GridItem(height: 150,title:"1"),
//            GridItem(height: 90,title:"1"),
//            GridItem(height: 140,title:"1"),
//                           ])
//        
//    ]
//    let spacing: CGFloat = 10
//    let horizontalPadding : CGFloat = 10
//    var body: some View {
//        HStack(alignment: .top, spacing:spacing ){
//            ForEach(columns){ columns in
//                LazyVStack(spacing:spacing){
//                    ForEach(columns.gridItems){
//                        gridItems in
//                    }
//                }
//            }
//        }.padding(.horizontal,horizontalPadding)
//}
//}
struct PintrestGridView_Previews: PreviewProvider {
    static var previews: some View {
        PintrestGridView()
    }
}
