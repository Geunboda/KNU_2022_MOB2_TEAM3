//
//  Home.swift
//  SmartScheduler
//
//  Created by 신찬규 on 5/12/22.
//

import SwiftUI

struct Home: View {
    @State var showAddSchedulerView: Bool = false
    @State var currentDate: Date = Date()
    
    var body: some View {
        VStack {
            TitleBar()
            ScrollView(.vertical, showsIndicators: false) {
                DatePickerView(currentDate: $currentDate)
            }
            AddButton(content: "일정 추가하기", action: {
                showAddSchedulerView = true
            })
        }.sheet(isPresented: $showAddSchedulerView) {
            AddSchedulerView(showModal: $showAddSchedulerView)
        }
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
