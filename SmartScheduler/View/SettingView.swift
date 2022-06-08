//
//  SettingView.swift
//  SmartScheduler
//
//  Created by Bogeun Kim on 2022/05/10.
//

import SwiftUI
import UIKit
import CoreData

struct SettingView: View {
    
    @Binding var showModal: Bool
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<UserInfo>
    @Environment(\.managedObjectContext) var moc
    
    @State var prepare_hour: Int = 0
    @State var prepare_min: Int = 0
    
    @State var sleep_hour: Int = 0
    @State var sleep_min: Int = 0
    
    @State var Long: Double = 0
    @State var Lat: Double = 0
    
    var body: some View {
        SheetTitleBar(content: "기본 설정", showModal: $showModal)
        ScrollView {
            TimeSetting(hour: $prepare_hour, min: $prepare_min, content: "준비 소요 시간", discription: "평소 나갈때 준비하는 시간을 입력해주세요.", image: "hare.fill")
            Spacer()
            TimeSetting(hour: $sleep_hour, min: $sleep_min, content: "수면 시간", discription: "보통 몇 시간 주무시나요?", image: "bed.double.fill")
            Spacer()
            LocationSetting(content: "출발 위치", discription: "어디서 주로 출발하시나요?", image: "figure.walk")
        }
        AddButton(content: "저장 하기", action: {
            let userInfo = UserInfo(context: moc)
            userInfo.id = UUID()
            userInfo.defualt_sleep_hour = Int32(sleep_hour)
            userInfo.defualt_sleep_minute = Int32(sleep_min)
            userInfo.default_preparing_hour = Int32(prepare_hour)
            userInfo.default_preparing_minute = Int32(prepare_min)
            userInfo.start_point_x = Long
            userInfo.start_point_y = Lat

            try? moc.save()
            showModal = false
        })
    }
}

struct TimeSetting: View {
    @Binding var hour: Int
    @Binding var min: Int
    
    var content: String
    var discription: String
    var image: String
    
    var body: some View {
        Text(content)
            .padding(.vertical)
            .font(.title.bold())
        Image(systemName: image)
            .font(.title)
        Text(discription)
            .padding(.vertical)
        HStack {
            Button {
                decreaseTime(&hour, &min)
            } label: {
                Image(systemName: "minus.circle.fill")
                    .font(.title)
            }
            Text("\(hour)시간 \(min)분")
                .font(.title2.bold())
                .padding(.horizontal, 30)
            Button {
                increaseTime(&hour, &min)
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
            }
        }
    }
    
    func decreaseTime(_ hour: inout Int, _ min: inout Int) -> () {
        if min == 0 {
            if hour > 0 {
                min = 30
                hour -= 1
            }
        } else if min == 30 {
            min = 0
        }
        
    }
    
    func increaseTime(_ hour: inout Int, _ min: inout Int) -> () {
        if min == 0 {
            min = 30
        } else if min == 30 {
            min = 0
            hour += 1
        }
      
    }
}

struct LocationSetting: View {
    var content: String
    var discription: String
    var image: String
    
    var body: some View {
        Text(content)
            .padding(.vertical)
            .font(.title.bold())
        Image(systemName: image)
            .font(.title)
        Text(discription)
            .padding(.vertical)
        Image("Map")
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
