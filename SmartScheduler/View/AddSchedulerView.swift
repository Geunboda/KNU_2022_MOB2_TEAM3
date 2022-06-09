//
//  AddSchedulerView.swift
//  SmartScheduler
//
//  Created by LeeWonGeun on 2022/05/11.
//

import SwiftUI
import UIKit
import SnapKit
import MapKit

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
    @State var showMapView: Bool = false
    @State var arrivalPlace = ""
    @State var scheduleName = ""
    @State var scheduleTime = ""
    @State var alarmOn = false
    @State var schedulePlace = ""

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
                        TextField("목적지 입력하기", text: $arrivalPlace)
                            .padding()
                        AddButton(content: "목적지 확인하기", action: {
                            //arrivalPlace = $arrivalPlace
                            showMapView = true
                        })
                    }
                    .sheet(isPresented: $showMapView) {
                        AddMapView(arrival: $arrivalPlace, showMapModal: $showMapView)
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
                        
                    }
                    .padding(.horizontal)
                    Button("자동차") {
                        
                    }
                    .padding(.horizontal)
                    Button(action:  {
                        ContentView()
                    }, label: {
                        Text("도보")
                    })
                    .padding(.horizontal)
                    
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
