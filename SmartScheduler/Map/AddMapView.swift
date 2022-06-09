//
//  MapView.swift
//  SmartScheduler
//
//  Created by seyonee on 2022/06/08.
//

import CoreLocation
import UIKit
import MapKit
import SwiftUI

struct AddMapView: View {
    @Binding var arrival: String
    @Binding var showMapModal: Bool
    
    let baseLocation = Location(name: "Apple", latitude: 37.334831452184766, longitude: -122.00885398493168)

    @State var mapRegion: MKCoordinateRegion
    
    var arrivalLocation: Location
    var locations: [Location]
    
    // 37.334831452184766, -122.00885398493168
    var body: some View {
        VStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapPin(coordinate: location.coordinate)
            }
        }
    }
    init(arrival: Binding<String>, showMapModal: Binding<Bool>) {
        self._arrival = arrival
        self._showMapModal = showMapModal
        arrivalLocation = Location.getLocation(place: arrival.wrappedValue)
        locations = [arrivalLocation, baseLocation]
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: arrivalLocation.latitude, longitude: arrivalLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}
