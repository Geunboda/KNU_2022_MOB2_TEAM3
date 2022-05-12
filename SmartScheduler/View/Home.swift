//
//  Home.swift
//  SmartScheduler
//
//  Created by 신찬규 on 5/12/22.
//

import SwiftUI

struct Home: View {
    @State var currentDate: Date = Date()
    var body: some View {
        // Title bar
        HStack {
            Text("Smart Scheduler")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "bell.fill")
                .foregroundColor(.blue)
        }
        .padding(.horizontal)
        .padding(.vertical)
        
        // Calendar
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                DatePicker(currentDate: $currentDate)
            }
            .padding(.vertical)
        }
        
        // Task add button
        HStack {
            Button {
                
            } label: {
                Text("일정 추가하기")
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color("Blue"), in: Capsule())
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .foregroundColor(.white)
        .background(.ultraThinMaterial)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
