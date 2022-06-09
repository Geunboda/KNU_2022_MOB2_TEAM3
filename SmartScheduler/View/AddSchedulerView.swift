//
//  AddSchedulerView.swift
//  SmartScheduler
//
//  Created by LeeWonGeun on 2022/05/11.
//

import SwiftUI
import UIKit

struct AddSchedulerView: View {
    @Binding var showModal: Bool
    @FetchRequest(sortDescriptors: []) var schedule: FetchedResults<Schedule>
    @Environment(\.managedObjectContext) var moc
    
    @State var prepareAlarm: Bool = false
    @State var sleepAlarm: Bool = false
    
    @State var title: String = ""
    
    @State var startDate: Date = Date()
    @State var finishDate: Date = Date()
    @State var transportation: Int16 = 0
    
    @State var placeName: String = ""
    @State var placeLong: Double = 0
    @State var placeLat: Double = 0
    
    var body: some View {
        SheetTitleBar(content: "일정 설정", showModal: $showModal)
        ScrollView {
            ScheduleEditView(title: $title,
                             startDate: $startDate,
                             finishDate: $finishDate,
                             prepareAlarm: $prepareAlarm,
                             sleepAlarm: $sleepAlarm,
                             placeName: $placeName,
                             placeLong: $placeLong,
                             placeLat: $placeLat,
                             transportation: $transportation)
                .padding(.horizontal)
        }
        AddButton(content: "저장 하기", action: {
            let schedule = Schedule(context: moc)
            schedule.id = UUID()
            
            schedule.prepareAlarm = prepareAlarm
            schedule.sleepAlarm = sleepAlarm
            
            schedule.startDate = startDate
            schedule.finishDate = finishDate
            schedule.transportation = transportation
            
            schedule.title = title
            
            schedule.placeName = placeName
            schedule.placeLong = placeLong
            schedule.placeLat = placeLat

            try? moc.save()
            showModal = false
        })
    }
}

struct SheetTitleBar: View {
    var content: String
    @Binding var showModal: Bool
    var body: some View {
        HStack {
            Button(action: {
                showModal.toggle()
            }) {
                Image(systemName: "xmark")
            }
            Text(content).font(.title3.bold())
        }
        .padding([.horizontal, .vertical])
    }
}

struct ScheduleEditView: View {
    @Binding var title: String
    @Binding var startDate: Date
    @Binding var finishDate: Date
    
    @Binding var prepareAlarm: Bool
    @Binding var sleepAlarm: Bool
    
    @Binding var placeName: String
    @Binding var placeLong: Double
    @Binding var placeLat: Double
    
    @Binding var transportation: Int16
    
    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return formatter
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    Text("일정 내용")
                        .multilineTextAlignment(.leading)
                        .padding()
                    TextField("일정 내용 입력", text: $title)
                        .padding()
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    VStack(alignment: .leading) {
                        Text("일정 시간")
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading])
                        DatePicker(selection: $startDate, label: { Text("시작") })
                            .padding(.horizontal)
                        DatePicker(selection: $finishDate, label: { Text("종료") })
                            .padding([.leading, .bottom, .trailing])
                    }
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    VStack {
                        Text("일정 장소")
                            .multilineTextAlignment(.leading)
                            .padding()
                        TextField("장소:",text: $placeName)
                            .padding()
                        Button("검색") {
                            
                        }
                        .padding(.bottom)
                    }
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    Text("교통편")
                        .multilineTextAlignment(.leading)
                    Button("대중교통") {
                        transportation = 1
                    }
                    .padding(.horizontal)
                    Button("자동차") {
                        transportation = 2
                    }
                    .padding(.horizontal)
                    Button("도보") {
                        transportation = 3
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    Toggle("준비 알람 설정",isOn: $prepareAlarm)
                }
                .padding()
                HStack {
                    Toggle("수면 알람 설정",isOn: $sleepAlarm)
                }
                .padding()
            }
        }
    }
}
