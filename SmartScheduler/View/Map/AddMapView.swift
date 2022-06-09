//
//  AddMapView.swift
//  SmartScheduler
//
//  Created by seyonee on 2022/06/08.
//

import CoreLocation
import UIKit
import MapKit
import SwiftUI

struct AddMapView: View {
    let baseLocation = Location(name: "KNU", latitude: 35.8882118, longitude: 128.6109155)

    @State var mapRegion: MKCoordinateRegion
    
    var locations: [Location]
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapPin(coordinate: location.coordinate)
            }
        }
    }
    
    init() {
        locations = [baseLocation]
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: baseLocation.latitude, longitude: baseLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}
