//
//  HomeOptionCell.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/27/22.
//

import SwiftUI

struct HomeOptionCell: View {
    @State var item: homeMenuCategoryListModel
    var body: some View {
        VStack (alignment: .center, spacing: 10){
            VStack {
                ImageWithURL(item.image)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .frame(width: 90,height: 90)
            }
            .frame(width: 90,height: 90)
            
            Text(item.title).font(.system(size: 16)).bold().foregroundColor(.black)
                .lineLimit(1)
        }.padding()
            .background(.white)
            .cornerRadius(8)
            .shadow(radius: 8)
    }
}

struct HomeOptionCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeOptionCell(item: homeMenuCategoryListModel(image: "https://www.kingsfund.org.uk/sites/default/files/2017-06/Social%20care%20teaser.png", name: "adultcare", title: "Adult care"))
    }
}
