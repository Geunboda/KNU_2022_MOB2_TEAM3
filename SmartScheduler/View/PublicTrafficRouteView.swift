//
//  PublicTrafficRouteView.swift
//  SmartScheduler
//
//  Created by LeeWonGeun on 2022/06/08.
//

import SwiftUI
import UIKit
import ODsaySDK

struct PublicTrafficRouteView: View {
    @Binding var showModal : Bool
    
    func viewDidLoad() {
        ODsayService.sharedInst().setApiKey("iLLJul5KVhowQ4a2oobPhg")    //SDK 인증
        ODsayService.sharedInst().setTimeout(5000)    //통신 타임아웃 설정

        //버스노선 상세정보 조회 호출
        ODsayService.sharedInst().requestBusLaneDetail("12018") {
            (retCode:Int32, resultDic:[AnyHashable : Any]?) in
            if retCode == 200 {
                       print(resultDic!.description)
            } else {
                       print(resultDic!.description)
            }
        }
    }
    
    var body: some View {
        SheetTitleBar(content: "대중 교통 경로", showModal: $showModal)
        ScrollView {
            HStack {
                Text("일정 내용")
                Button("경로 탐색"){
                    viewDidLoad()
                }
            }
        }
    }
}
