//
//  HumanverseApp.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/18/22.
//

import SwiftUI
import Firebase

@main
struct HumanverseApp: App {
    
    //MARK: Intialize Firebase
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
