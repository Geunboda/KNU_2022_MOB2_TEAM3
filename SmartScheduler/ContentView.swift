//
//  ContentView.swift
//  SmartScheduler
//
//  Created by Bogeun Kim on 2022/05/10.
//

import SwiftUI
import UIKit


struct ContentView: View {

    var body: some View {
        
        VStack {
            ScrollView {
                
                Text("기본 설정").font(.title3)
                Spacer()
                SettingBar(content: "준비 소요 시간").offset(x: 0, y: 30)
                Spacer()
                SettingBar(content: "수면 시간").offset(x:0, y: 50)
                Spacer()
                LocationBar(content: "위치").offset(x:0, y: 70)
                Button("설정 완료") {

                }.offset(x:0, y: 100)
                
            }
        }
        
    }
}

struct SettingBar: View {
    
    @State var time = ""
    var content: String
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(.white)
            shape.stroke(lineWidth: 2)
            Text(content)
                .offset(x:0, y: -40)
            VStack{
                TextField("시간을 입력하시오", text:$time)
                    .frame(width: 200, height: 10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .padding()
                Button("입력") {
                    hideKeyboard()
                }
            }.offset(x:0, y: 10)
        }
        .frame(width: 320, height: 130)
        
    }
}

struct LocationBar: View {
    
    @State var time = ""
    var content: String
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(.white)
            shape.stroke(lineWidth: 2)
            Text(content)
                .offset(x:0, y: -100)
            VStack{
                
                Button("입력") {
                    hideKeyboard()
                }
            }
        }.frame(width: 320, height: 260)
    }
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
