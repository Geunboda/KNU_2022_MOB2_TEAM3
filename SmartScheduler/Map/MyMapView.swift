//
//  MyMapView.swift
//  SmartScheduler
//
//  Created by seyonee on 2022/06/09.
//

import CoreLocation
import UIKit
import MapKit
import SwiftUI

class LocationHelper: NSObject, ObservableObject {

    static let shared = LocationHelper()
    static let DefaultLocation = CLLocationCoordinate2D(latitude: 45.8827419, longitude: -1.1932383)

    static var currentLocation: CLLocationCoordinate2D {
        guard let location = shared.locationManager.location else {
            return DefaultLocation
        }
        return location.coordinate
    }

    private let locationManager = CLLocationManager()

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location manager changed the status: \(status)")
    }
}

//현재 내 위치 받는 코드
//let location = LocationHelper.currentLocation

struct MyMapView: View {
    let location = LocationHelper.currentLocation
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    let myLocation = Location(name: "My Location", latitude: location.latitude, longitude: location.longitude)
    var baseLocation = Location(name: "Apple", latitude: 37.334831452184766, longitude: -122.00885398493168)
    var places = [myLocation, baseLocation]
    
    var body: some View {
        ZStack {
            VStack {
                Map(coordinateRegion: $mapRegion, annotationItems: places) { location in
                    MapPin(coordinate: location.coordinate)
                }
            }
        }
    }
}
