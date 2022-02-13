//
//  AllServiceCategoryView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/13/22.
//

import SwiftUI
import AlertToast

struct AllServiceCategoryView: View {
    @ObservedObject private var menuList = homeServiceList()
    @State private var toastLoading = false
    @State private var toastSuccess = false
    @State private var toastError = false
    @State private var toastMessage = ""
    
    
    let layout = [GridItem(.flexible()),
                  GridItem(.flexible()),
                  GridItem(.flexible())]
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    LazyVGrid(columns: layout, spacing: 10) {
                        ForEach(self.menuList.homeMenuCategoryList.indices, id: \.self){ idx in
                            let item = self.menuList.homeMenuCategoryList[idx]
                            NavigationLink(destination: {
                                HomeServicesView(searchName: item.title, searchKeys: item.name)
                            }, label: {
                                HomeOptionCell(item: item)
                            })

                        }
                    }
                }.padding([.leading, .trailing])
                .onAppear{
                    self.toastLoading = true
                    self.menuList.fetchHomeMenuCategoryData()
                    self.toastLoading = false
                }
            })
                .navigationBarTitle("All Services")
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct AllServiceCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AllServiceCategoryView()
    }
}
