//
//  RootNavigation.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/23/22.
//

import SwiftUI


//MARK: go to registration view
func goRegistrationView() {
    if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows.first {
        window.rootViewController = UIHostingController(rootView:RegistrationView())
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

//MARK: go to login view
func goLoginView() {
    if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows.first {
        window.rootViewController = UIHostingController(rootView:LoginScreenView())
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

//MARK: go to reset pass view
func goResetPassView() {
    if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows.first {
        window.rootViewController = UIHostingController(rootView:ResetPasswordView())
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

//MARK: go to home dashboard
func goHomeDashboard() {
    if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows.first {
        window.rootViewController = UIHostingController(rootView:HomeMainView())
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
