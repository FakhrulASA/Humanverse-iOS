//
//  HistoryListModel.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import Foundation

struct historyList: Identifiable {
    let id = UUID().uuidString
    let docId, serviceName, price, date, time, provider: String
    let status: Int
}
