//
//  HomeModel.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 1/26/22.
//

import Foundation

//MARK: Home image slider model (static)
struct homeImageSliderModel: Identifiable, Hashable {
    let id = UUID()
    let sliderId: Int
    let sliderImageName: String
}

//MARK: Home option list - (static)
struct homeOptionListModel: Identifiable, Hashable {
    let id = UUID()
    let optionID: Int
    let optionName, optionKey ,optionImageName: String
}

struct homeMenuCategoryListModel: Identifiable {
    let id: String = UUID().uuidString
    let image, name, title: String
}

//MARK: Home service list
struct homeServiceListModel: Identifiable {
    let id: String = UUID().uuidString
    let docID, banner, serviceName, description, price, country, state, city, serviceWebsite, email: String
}

//MARK: subscripion list
struct getUserSubscriptionListModel: Identifiable {
    let id: String = UUID().uuidString
    let email, time: String
}
