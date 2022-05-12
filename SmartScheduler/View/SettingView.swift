//
//  SettingView.swift
//  SmartScheduler
//
//  Created by Bogeun Kim on 2022/05/10.
//

import SwiftUI
import UIKit

struct SettingView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        SheetTitleBar(content: "기본 설정", showModal: $showModal)
        ScrollView {
            TimeSetting(content: "준비 소요 시간", discription: "평소 나갈때 준비하는 시간을 입력해주세요.", image: "hare.fill")
            Spacer()
            TimeSetting(content: "수면 시간", discription: "보통 몇 시간 주무시나요?", image: "bed.double.fill")
            Spacer()
            LocationSetting(content: "출발 위치", discription: "어디서 주로 출발하시나요?", image: "figure.walk")
        }
        AddButton(content: "저장 하기", action: {
            showModal = false
        })
    }
}

struct TimeSetting: View {
    @State var hour: Int = 0
    @State var min: Int = 0
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
