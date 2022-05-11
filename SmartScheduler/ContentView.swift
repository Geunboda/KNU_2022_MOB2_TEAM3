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
            SettingBar(content: "기본 준비 시간")
            Spacer()
            SettingBar(content: "기본 수면 시간")
            Spacer()
            SettingBar(content: "temp")
            Button("설정 완료") {
                
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
            shape.stroke(lineWidth: 5)
            Text(content)
                .offset(x:0, y: -70)
            VStack{
                TextField("시간을 입력하시오", text:$time)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    //.offset(x: 0, y: 70)
                    .padding()
                Button("입력") {
                    hideKeyboard()
                }//.offset(x:0, y: 60)
                
            }
        }
    }
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct FirstView: View {

    var body: some View {
        NavigationView{
            List{
                Text("Hello")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
