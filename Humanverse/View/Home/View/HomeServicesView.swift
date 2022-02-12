//
//  HomeServicesView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI

struct HomeServicesView: View {
    @ObservedObject private var serviceList = homeServiceList()
    @State var searchName: String
    @State var searchKeys: String
    var body: some View {
        ZStack {
            Color.gray.opacity(0.02).ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 10){
                        ForEach(self.serviceList.homeServicesList.indices, id: \.self){ idx in
                            let tempItem = self.serviceList.homeServicesList[idx]
                            NavigationLink(destination: {
                                HomeServicesDetailsView(item: tempItem)
                            }, label: {
                                HomeServiceCell(item: tempItem)
                                    .padding([.leading, .trailing])
                            })
                            
                        }
                    }.onAppear{
                        if self.searchKeys == "" {
                            self.serviceList.fetchAllData()
                        } else {
                            self.serviceList.fetchData(searchKey: searchKeys)
                        }
                    }
                }
            }.navigationBarTitle(self.searchName)
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear{
            if self.searchKeys == ""{
                self.searchName = "All Services"
            }
        }
    }
}

struct HomeServicesView_Previews: PreviewProvider {
    static var previews: some View {
        HomeServicesView(searchName: "carwash", searchKeys: "Car wash")
    }
}
