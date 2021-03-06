//
//  AddSchedulerView.swift
//  SmartScheduler
//
//  Created by LeeWonGeun on 2022/05/11.
//

import SwiftUI
import UIKit

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

struct AddScheduleView: View {
    @Binding var showModal: Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var userInfo: FetchedResults<UserInfo>
    
    @State var prepareAlarm: Bool = false
    @State var sleepAlarm: Bool = false
    
    @State var title: String = ""
    @State var startDate: Date = Date()
    @State var finishDate: Date = Date()
    
    @State var placeName: String = ""
    @State var placeLong: Double = 0
    @State var placeLat: Double = 0
    
    @State var transportation: String = ""
    
    let calendar = Calendar.current
    let alarm = MakeAlarm()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("내용", text: $title)
                    NavigationLink(destination: SearchView(searchText: $placeName)) {
                        Text("장소")
                    }
                }
                Section() {
                    DatePicker(selection: $startDate, label: { Text("시작") })
                    DatePicker(selection: $finishDate, label: { Text("종료") })
                }
                Section() {
                    Picker("교통편", selection: $transportation) {
                        Text("대중교통").tag("대중교통")
                        Text("자동차").tag("자동차")
                        Text("도보").tag("도보")
                    }
                }
                Section() {
                    Toggle("준비 알람",isOn: $prepareAlarm)
                    Toggle("수면 알람",isOn: $sleepAlarm)
                }
            }
            .navigationBarTitle("일정 생성", displayMode: .inline)
            .navigationBarItems(leading: Button("취소") {
                showModal.toggle()
            }, trailing: Button("저장") {
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
            
                // let scheduleDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: schedule.startDate!)
                
                if schedule.sleepAlarm {
//                    let sleepHour = 8
//                    let sleepMin = 0
//                    let _hour = scheduleDateComponents.hour! - sleepHour
//                    let _minute = scheduleDateComponents.minute! - sleepMin
           
                    alarm.sendNotification(title: schedule.title!, body: "지금 주무셔야 합니다.")
                }
                
                if schedule.prepareAlarm {
//                    let prepareHour = 1
//                    let prepareMin = 30
//                    let _hour = scheduleDateComponents.hour! - prepareHour
//                    let _minute = scheduleDateComponents.minute! - prepareMin
           
                    alarm.sendNotification(title: schedule.title!, body: "지금 준비하셔야 합니다.")
                }
                showModal = false
            })
        }
    }
}
