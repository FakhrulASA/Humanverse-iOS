//
//  UserDefaultsManager.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/4/22.
//

import Foundation

class UserDefaultsManager{
    static var KEY_IS_LOGIN = "IS_LOGIN"
    
    //MARK: Is user login
    func storeUserLogin(){
        UserDefaults.standard.set(true, forKey: UserDefaultsManager.KEY_IS_LOGIN)
    }
    
    func logOutUser(){
        UserDefaults.standard.set(false, forKey: UserDefaultsManager.KEY_IS_LOGIN)
    }
}
