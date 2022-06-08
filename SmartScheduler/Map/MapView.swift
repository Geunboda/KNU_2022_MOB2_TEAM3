//
//  MapView.swift
//  SmartScheduler
//
//  Created by seyonee on 2022/06/09.
//

import CoreLocation
import UIKit
import MapKit
import SwiftUI

//장소 이름, 위도, 경도 저장하는 Location 클래스
class Location: Identifiable {
    let id = UUID()
    let name: String
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    init (name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    //위도, 경도 정보 가져오는 함수
    func getLocation(place : String) -> Location {
        let geocoder = CLGeocoder()
        var lat : Double = 0.0
        var long : Double = 0.0
        geocoder.geocodeAddressString(place) { (placemark, error) in
            guard error == nil else { return print(error!.localizedDescription) }
            guard let location = placemark?.first?.location else { return print("데이터가 없습니다.") }
            lat = location.coordinate.latitude
            long = location.coordinate.longitude
            print(lat, long)
        }
        return Location(name: place, latitude: lat, longitude: long)
    }
}
