//
//  WonServiceCellView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI

struct WonServiceCellView: View {
    @State var item: wonServiceListModel
    var body: some View {
        VStack{
            VStack {
                ImageWithURL(item.banner)
                    .cornerRadius(12, corners: [.topLeft, .topRight])
                    .shadow(radius: 5)
                    .frame(height: 160)
            }
            HStack {
                VStack(alignment: .leading,spacing: 10) {
                    Text(item.serviceName).font(.system(size: 12)).bold().foregroundColor(.black)
                        .lineLimit(1)
                    
                    Text(item.description).font(.system(size: 12)).bold().foregroundColor(.black)
                        .lineLimit(1)
                        .padding(.bottom)
                }.padding(.leading)
                Spacer()
                VStack(spacing: 5) {
                    Text("Starting from").font(.system(size: 10))
                        .foregroundColor(.white)
                    
                    Text("\(item.price)$").font(.system(size: 12))
                        .foregroundColor(.white).bold()
                        
                }.frame(width: 80)
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("field_color"), lineWidth: 2))
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color("field_color")))
                .padding()
            }
        }
        .background(.white)
        .cornerRadius(12)
        .shadow(radius: 12)
    }
}

struct WonServiceCellView_Previews: PreviewProvider {
    static var previews: some View {
        WonServiceCellView(item: wonServiceListModel(banner: "https://firebasestorage.googleapis.com:443/v0/b/humanverse-57f4d.appspot.com/o/service_banner%2Fmahmudurrahman2066@gmail.comcharities?alt=media&token=ca67141f-f207-4777-8b0b-e6277cfdc024", serviceName: "test charities", description: "Test Description", price: "100"))
    }
}
