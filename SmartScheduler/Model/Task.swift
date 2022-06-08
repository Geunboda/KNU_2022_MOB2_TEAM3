//
//  Task.swift
//  SmartScheduler
//
//  Created by 신찬규 on 5/12/22.
//

import SwiftUI

// Task Model and Sample Tasks
// Array of Tasks



struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

// Total Task Meta View
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

// Sample Date for Testing
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

// Sample Tasks
var tasks: [TaskMetaData] = [
    TaskMetaData(task: [
        Task(title: "모바일앱프로그래밍2 총괄 회의"),
        Task(title: "원근 선배 점심"),
        Task(title: "세연 누나 저녁"),
    ], taskDate: getSampleDate(offset: 1)),
    TaskMetaData(task: [
        Task(title: "근보 선배 점심"),
    ], taskDate: getSampleDate(offset: -3)),
    TaskMetaData(task: [
        Task(title: "모바일앱프로그래밍2 구현 회의"),
    ], taskDate: getSampleDate(offset: -8)),
    TaskMetaData(task: [
        Task(title: "모바일앱프로그래밍2 기획 회의"),
    ], taskDate: getSampleDate(offset: 10)),
    TaskMetaData(task: [
        Task(title: "자살"),
    ], taskDate: getSampleDate(offset: -22)),
    TaskMetaData(task: [
        Task(title: "치킨 먹기"),
    ], taskDate: getSampleDate(offset: 15)),
    TaskMetaData(task: [
        Task(title: "피자 먹기"),
    ], taskDate: getSampleDate(offset: -20)),
]
