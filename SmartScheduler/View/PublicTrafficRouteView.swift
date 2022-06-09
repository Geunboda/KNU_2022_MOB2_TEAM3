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
    @State var result = Route()
    
    
    var body: some View {
        SheetTitleBar(content: "대중 교통 경로", showModal: $showModal)
        ScrollView {
            VStack {
                Text("경로 탐색 결과:")
                showRouteInfoView(result: $result)
            }
        }
    }
}

struct showRouteInfoView : View {
    @Binding var result: ResultInfo?
    var body: some View{
        VStack{
            if(result == nil){
                Text("경로로 가는 대중 교통이 없습니다!")
            } else{
                Text(String(result?.result.busCount ?? 0))
            }
        }
    }
}

func Route() -> ResultInfo?{
    var routeInfo: ResultInfo?
    var pathInfo: String = ""
    ODsayService.sharedInst().setApiKey("iLLJul5KVhowQ4a2oobPhg")    //SDK 인증
    ODsayService.sharedInst().setTimeout(5000)    //통신 타임아웃 설정
    ODsayService.sharedInst().requestSearchPubTransPath("128.62864955761276",sy: "35.8791619244707",ex: "128.61454739896172",ey: "35.885516134309185", opt: 0, searchType: 0, searchPathType: 0)
    {
        (retCode:Int32, resultDic:[AnyHashable : Any]!) in
        if retCode == 200 {
            do {
                let resultJson = try JSONSerialization.data(withJSONObject: resultDic!, options: .prettyPrinted)
                routeInfo = try JSONDecoder().decode(ResultInfo.self, from: resultJson)
                print(String(data: resultJson, encoding: .utf8)!)
                print("////////////")
                var i = 0
                let stationInfo = routeInfo!.result.path[0].subPath[1].passStopList
                while(i<=routeInfo!.result.path[0].info.totalStationCount){
                    pathInfo.append((stationInfo?.stations[i].stationName)!)
                    pathInfo.append(#"\#n"#)
                    i+=1
                }
                print(pathInfo)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print(resultDic!.description)
        }
    }
    print(routeInfo?.result.busCount ?? "노오오오오오오오오")
    return routeInfo ?? nil
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

struct ResultInfo: Codable{
    let result: Result // 1
}

struct Result: Codable{
    let busCount: Int // 1-3
    let searchType: Int // 1-1
    let path: [Path] // 1-9
}

struct Path: Codable{ // 1-9
    let pathType: Int // 1-9-1
    let info: Info // 1-9-2
    let subPath: [SubPath] //1-9-3
}

struct Info: Codable{ //1-9-2
    let totalWalk: Int //1-9-2-2
    let totalTime: Int //1-9-2-3
    let payment: Int // 4
    let busTransitCount: Int // 5
    let subwayTransitCount: Int // 6
    let firstStartStation: String // 8
    let lastEndStation: String // 9
    let busStationCount: Int // 11
    let subwayStationCount: Int //12
    let totalStationCount: Int
}

struct SubPath: Codable{ //1-9-3
    let trafficType: Int // 1-9-3-1
    let distance: Double //2
    let sectionTime: Int //3
    let passStopList : PassStopList? //31
}

struct PassStopList: Codable{ // 1-9-3-31
    let stations: [Stations]
}

struct Stations: Codable{
    let stationName: String
}
