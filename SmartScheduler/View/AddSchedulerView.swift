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
    
    var body: some View {
        SheetTitleBar(content: "일정 설정", showModal: $showModal)
        ScrollView {
            ScheduleEditView()
                .padding(.horizontal)
        }
        AddButton(content: "저장 하기", action: {
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

struct ScheduleEditView: View{
    @State var scheduleName = ""
    @State var scheduleTime = ""
    @State var alarmOn = false
    @State var schedulePlace = ""
    @State var traffic = 0 //0: 미선택 1: 대중교통 2: 자차 3: 도보
    
    @State var showPublicTrafficRouteView: Bool = false
    @State var origin_x: String!
    @State var origin_y: String!
    @State var dest_x: String!
    @State var dest_y: String!
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    Text("일정 내용")
                        .multilineTextAlignment(.leading)
                        .padding()
                    TextField("일정 내용 입력", text: $scheduleName)
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
                        DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { Text("시작") })
                            .padding(.horizontal)
                        DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { Text("종료") })
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
                        TextField("장소:",text:$schedulePlace)
                            .padding()
                        Button("검색") {
                            hideKeyboard()
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
                        traffic = 1
                    }
                    .padding(.horizontal)
                    Button("자동차") {
                        traffic = 2
                    }
                    .padding(.horizontal)
                    Button("도보") {
                        traffic = 3
                    }
                    .padding(.horizontal)
                    
                }
                .padding()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    Button("경로 검색") {
                        if(traffic == 1){
                            showPublicTrafficRouteView = true
                        }
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $showPublicTrafficRouteView) {
                        PublicTrafficRouteView(showModal: $showPublicTrafficRouteView, originLatitude: $origin_y,originLongitude: $origin_x,destLatitude: $dest_y,destLongitude: $dest_x)
                    }
                }
                .padding()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    Toggle("알람 설정",isOn: $alarmOn)
                }
                .padding()
            }
        }
    }
}
