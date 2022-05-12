//
//  ContentView.swift
//  SmartScheduler
//
//  Created by seyonee on 2022/05/10.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("출발장소설정").font(.title3)
                LocationBar(content: "기본 출발 장소").offset(x:0, y: 0)
                SettingBar(content: "").offset(x: 0, y: 10)
                Button("저장하기") {

                }.offset(x:0, y: 100)
                
            }
        }
        //
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
                HStack{
                    TextField("장소입력", text:$time)
                        .frame(width: 200, height: 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .padding()
                    Button("입력") {
                        hideKeyboard()
                    }
                }.offset(x:0, y: -35)
            }
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
                .offset(x:0, y: -110)
            VStack{
                
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
