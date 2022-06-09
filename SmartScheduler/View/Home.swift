//
//  Home.swift
//  SmartScheduler
//
//  Created by 신찬규 on 5/12/22.
//

import SwiftUI

struct Home: View {
    @State var showAddScheduleView: Bool = false
    @State var currentDate: Date = Date()
    let alarm = MakeAlarm()
    
    var body: some View {
        VStack {
            TitleBar()
            ScrollView(.vertical, showsIndicators: false) {
                DatePickerView(currentDate: $currentDate)
            }
            AddButton(content: "일정 추가하기", action: {
                showAddScheduleView = true
            })
        }
        .sheet(isPresented: $showAddScheduleView) {
            AddScheduleView(showModal: $showAddScheduleView)
        }
        .onAppear(){
            alarm.requestAuthorization()
            alarm.sendNotification()
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.year = 2022
        dateComponents.month = 6
        dateComponents.day = 9
        dateComponents.hour = 19
        dateComponents.minute = 3
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}

struct TitleBar: View {
    @State var showSettingrView: Bool = false
    
    var body: some View {
        HStack {
            Text("Smart Scheduler")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: {
                
            }) {
                Image(systemName: "bell.fill")
                    .foregroundColor(.blue)
            }
            Button(action: {
                showSettingrView = true
            }) {
                Image(systemName: "gearshape")
                    .foregroundColor(.blue)
            }
        }
        .padding([.horizontal, .vertical])
        .sheet(isPresented: $showSettingrView) {
            SettingView(showModal: $showSettingrView)
        }
    }
}

struct AddButton: View {
    var content: String
    var action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            Text(content)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("Blue"), in: Capsule())
        }
        .padding([.horizontal, .vertical])
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
