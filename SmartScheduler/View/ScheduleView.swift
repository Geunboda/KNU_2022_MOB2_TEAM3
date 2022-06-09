//
//  ScheduleView.swift
//  SmartScheduler
//
//  Created by 신찬규 on 6/9/22.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var showModal: Bool
    var schedule: Schedule
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        NavigationView {
            VStack {
                List {
                    VStack(alignment: .leading) {
                        Text(schedule.title!).font(.title.bold()).foregroundColor(.black).padding(.vertical)
                        Text("\(strToDate(date: schedule.startDate!))에서").foregroundColor(.gray)
                        Text("\(strToDate(date: schedule.finishDate!))까지").foregroundColor(.gray)
                    }
                    NavigationLink(destination: WalkRouteView()) {
                        Text("장소").foregroundColor(.black)
                    }
                    HStack {
                        Text("교통편").foregroundColor(.black)
                        Spacer()
                        Text(schedule.transportation!).foregroundColor(.gray)
                    }
                }.frame(alignment: .leading)
            }
            .navigationBarTitle("상세 일정", displayMode: .inline)
            .navigationBarItems(trailing: Button("삭제") {
                showModal.toggle()
                moc.delete(schedule)
                try? moc.save()
            })
        }
    }
    
    func strToDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일 (E) kk:mm"
        let convertStr = dateFormatter.string(from: date)
        return convertStr
    }
                         
    func transporationToStr(transporation: Int16) -> String {
        switch transporation {
            case 0:
                return "대중교통"
            case 1:
                return "자동차"
            case 2:
                return "도보"
            default:
                return ""
        }
    }
}
