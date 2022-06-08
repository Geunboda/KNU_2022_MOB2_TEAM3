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
    @Binding var originLatitude : String! // 위도
    @Binding var originLongitude : String! // 경도
    @Binding var destLatitude : String!
    @Binding var destLongitude : String!
    
    let decoder = JSONDecoder()
    
    func viewDidLoad() {
        var result: String!
        var parsedResult: ResultInfo?
        ODsayService.sharedInst().setApiKey("iLLJul5KVhowQ4a2oobPhg")    //SDK 인증
        ODsayService.sharedInst().setTimeout(5000)    //통신 타임아웃 설정
        ODsayService.sharedInst().requestSearchPubTransPath("128.62864955761276",sy: "35.8791619244707",ex: "128.61454739896172",ey: "35.885516134309185", opt: 0, searchType: 0, searchPathType: 0){
            (retCode:Int32, resultDic:[AnyHashable : Any]!) in
            if retCode == 200 {
                result = mDictToTextJson(rMDic: resultDic!)
                print(mDictToTextJson(rMDic: resultDic!))
                print("/////////////////")
                
                
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

func parseResult(_ result: String) -> ResultInfo? {
    let resultData = result.data(using: .nonLossyASCII)
    do {
        let parsedResult = try JSONDecoder().decode(ResultInfo.self, from: resultData!)
        return parsedResult
    } catch {
        print(error)
        return nil
    }
}

func mDictToTextJson(rMDic:[AnyHashable : Any]?) -> String {
    if let sText = rMDic?.description {
        if let bytes = sText.cString(using: String.Encoding.ascii) {
            return String(cString: bytes, encoding: String.Encoding.nonLossyASCII)!
        } else {
            return "No Data is Displayed"
        }
    } else {
        return "No Data is Displayed"
    }
}

struct ResultInfo: Decodable {
    let result: Result
    let busCount: Int
}

struct Result: Decodable{
    let searchType: Int
    let path: [Path]
}

struct Path: Decodable{
    let pathType: Int
    let info: Info
    let subPath: [SubPath]
}

struct Info: Decodable{
    let totalWalk: Int
    let totalTime: Int
    let payment: Int
    let busTransitCount: Int
    let subwayTransitCount: Int
    let firstStartStation: String
    let lastEndStation: String
    let busStationCount: Int
    let subwayStationCount: Int
}

struct SubPath: Decodable{
    let trafficType: Int
    let distance: Double
    let sectionTime: Int
    let passStopList: PassStopList
}

struct PassStopList: Decodable{
    let station: [Station]
}

struct Station: Decodable{
    let stationName: String
}
