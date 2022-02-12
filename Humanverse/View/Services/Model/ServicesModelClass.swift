//
//  ServicesModelClass.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/11/22.
//

import Foundation

//MARK: service category model
struct categoryServiceListModel: Identifiable, Hashable {
    let id = UUID()
    let categoryName: String
    let categoryKeys: String
}

//MARK: service country name model
struct countryListModel: Identifiable, Hashable {
    let id = UUID()
    let countryName: String
}

//MARK: get won service list model
struct wonServiceListModel: Identifiable {
    let id: String = UUID().uuidString
    let banner, serviceName, description, price: String
}
