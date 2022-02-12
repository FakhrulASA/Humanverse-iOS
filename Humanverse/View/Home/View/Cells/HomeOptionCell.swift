//
//  HomeOptionCell.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/27/22.
//

import SwiftUI

struct HomeOptionCell: View {
    @State var item: homeOptionListModel
    var body: some View {
        VStack (alignment: .center, spacing: 10){
            VStack {
                Image(item.optionImageName)
                    .resizable()
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .frame(width: 90,height: 90)
            }
            .frame(width: 90,height: 90)
            
            Text(item.optionName).font(.system(size: 16)).bold().foregroundColor(.black)
                .lineLimit(1)
        }.padding()
            .background(.white)
            .cornerRadius(8)
            .shadow(radius: 8)
    }
}

struct HomeOptionCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeOptionCell(item: homeOptionListModel(optionID: 3, optionName: "Auto Repair", optionKey: "carrepair", optionImageName: "ic_auto_repair"))
    }
}
