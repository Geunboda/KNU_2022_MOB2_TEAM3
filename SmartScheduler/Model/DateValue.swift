//
//  DateValue.swift
//  SmartScheduler
//
//  Created by 신찬규 on 5/12/22.
//

import SwiftUI

// Date Value Model
struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
