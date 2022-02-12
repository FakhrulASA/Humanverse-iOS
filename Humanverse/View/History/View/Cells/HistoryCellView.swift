//
//  HistoryCellView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI

struct HistoryCellView: View {
    @State var item: historyList
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(item.serviceName)").font(.system(size: 16))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding()
                Spacer()
            }.background(Color.purple)
            HStack {
                Text("Date: \(item.date), \(item.time)").font(.system(size: 14))
                    .bold()
                .foregroundColor(.black)
                Spacer()
                Text("Cost: \(item.price)$").font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color.purple)
                
            }.padding()
            if item.status == 1 {
                Text("Status: Pending").font(.system(size: 18)).bold()
                    .foregroundColor(Color.orange)
                    .padding([.leading, .trailing, .bottom])
            } else if item.status == 2 {
                Text("Status: Confirmed").font(.system(size: 18)).bold()
                    .foregroundColor(Color.green.opacity(0.5))
                    .padding([.leading, .trailing, .bottom])
            } else if item.status == 3 {
                Text("Status: Payment pending").font(.system(size: 18)).bold()
                    .foregroundColor(Color.purple.opacity(0.8))
                    .padding([.leading, .trailing, .bottom])
            } else {
                Text("Status: Completed").font(.system(size: 18)).bold()
                    .foregroundColor(Color.green)
                    .padding([.leading, .trailing, .bottom])
            }
        }.background(.white)
            .cornerRadius(12)
            .shadow(radius: 12)
    }
}

struct HistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCellView(item: historyList(docId: "abcd", serviceName: "Steve car wash", price: "400", date: "01/01/2022", time: "04:00", provider: "example", status: 1))
    }
    
//    (serViceName: "Steve car wash", serviceDate: "01/01/2022, 04:00", serviceCost: "400", serviceStatus: 2)
}
