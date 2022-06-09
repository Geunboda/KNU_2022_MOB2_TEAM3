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

struct MyMapView: View {
    @Binding var departure: String
    @Binding var showDeModal: Bool
    
    let baseLocation = Location(name: "Apple", latitude: 37.334831452184766, longitude: -122.00885398493168)

    @State var mapRegion: MKCoordinateRegion
    
    var departLocation: Location
    var locations: [Location]
    
    // 37.334831452184766, -122.00885398493168
    var body: some View {
        VStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapPin(coordinate: location.coordinate)
            }
            //print(arrivalLocation.latitude, arrivalLocation.longitude)
        }
        AddButton(content: "저장하기", action: {
            showDeModal = false
        })
    }
    init(departure: Binding<String>, showDeModal: Binding<Bool>) {
        self._departure = departure
        self._showDeModal = showDeModal
        departLocation = Location.getLocation(place: departure.wrappedValue)
//      print("(", arrivalLocation.latitude, arrivalLocation.longitude, ")")
        locations = [departLocation, baseLocation]
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: departLocation.latitude, longitude: departLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}
