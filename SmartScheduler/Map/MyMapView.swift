//
//  MyMapView.swift
//  SmartScheduler
//
//  Created by seyonee on 2022/06/09.
//
import SwiftUI
import MapKit

struct MyMapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let locations = [
        Location(name: "Buckingham Palace", latitude: 51.501, longitude: -0.141),
        Location(name: "Tower of London", latitude: 51.508, longitude: -0.076)
    ]

    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
            MapPin(coordinate: location.coordinate)
        }
    }
}

struct MyMapView_Previews: PreviewProvider {
    static var previews: some View {
        MyMapView()
    }
}
