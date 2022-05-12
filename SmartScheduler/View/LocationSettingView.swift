//
//  LocationSettingView.swift
//  SmartScheduler
//
//  Created by seyonee on 2022/05/10.
//
import SwiftUI
import UIKit

struct LocationSettingView: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("출발 장소 설정").font(.title3)
                // LocationBar(content: "기본 출발 장소").offset(x:0, y: 0)
                // SettingBar(content: "장소 입력", discription: "", image: "").offset(x: 0, y: 10)
            }
            AddButton(content: "저장 하기", action: {
                
            })
        }
    }
}
