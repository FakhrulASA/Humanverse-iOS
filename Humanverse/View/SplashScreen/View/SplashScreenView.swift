//
//  SplashScreenView.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/22/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive:Bool = false
    var body: some View {
        ZStack {
            Color("dark_color").ignoresSafeArea()
            VStack {
                if self.isActive {
                    if UserDefaults.standard.bool(forKey: UserDefaultsManager.KEY_IS_LOGIN)  {
                        HomeMainView()
                    } else {
                        LoginScreenView()
                    }
                } else {
                    Image("img_short_logo").resizable().frame(width: 180, height: 180, alignment: .center)
                }
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }

    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
