//
//  HistoryView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/27/22.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject private var tempHistoryList = historyListController()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.02).ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 10){
                        ForEach(self.tempHistoryList.historyListData.indices, id: \.self){ idx in
                            let tempItem = self.tempHistoryList.historyListData[idx]
                            NavigationLink(destination: {
                                HistoryProgressView(tempItem: tempItem)
                            }, label: {
                                HistoryCellView(item: tempItem)
                                    .padding([.leading, .trailing])
                            })
                            
                        }
                    }.onAppear{
                        self.tempHistoryList.fetchAllData()
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
