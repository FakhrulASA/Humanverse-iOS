//
//  HomeMainView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/27/22.
//

import SwiftUI

struct HomeMainView: View {
    @State var selection = 1
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            NavigationView {
                TabView(selection: $selection){
                    HomeView()
                        .tabItem{
                            Image(systemName: "house").resizable()
                            Text("Home")
                        }.navigationBarTitle("")
                        .navigationBarHidden(true)
                        .tag(1)
                    
                    HistoryView()
                        .tabItem{
                            Image(systemName: "arrow.clockwise").resizable()
                            Text("History")
                        }.navigationBarTitle("")
                        .navigationBarHidden(true)
                        .tag(2)
                    
                    ServiceMainView()
                        .tabItem{
                            Image(systemName: "briefcase.fill").resizable()
                            Text("Service")
                        }.navigationBarTitle("")
                        .navigationBarHidden(true)
                        .tag(3)
                    
                    ProfileView()
                        .tabItem{
                            Image(systemName: "person.fill").resizable()
                            Text("Profile")
                        }.navigationBarTitle("")
                        .navigationBarHidden(true)
                        .tag(4)
                }.accentColor(.purple)
            }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }.onAppear{
            UIApplication.topViewController()?.navigationController?.isNavigationBarHidden = true
        }
    }
}

struct HomeMainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMainView()  
    }
}
