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
    @Binding var arrival : String
    @Binding var showMapModal: Bool
    
    @State private var mapRegion: MKCoordinateRegion
    
    var arLocation: Location
    
    // 37.334831452184766, -122.00885398493168
    var baseLocation = Location(name: "Apple", latitude: 37.334831452184766, longitude: -122.00885398493168)
    
    init(arrival: Binding<String>, showMapModal: Binding<Bool>) {
        //self._arrival = arrival
        //self._showMapModal = showMapModal
        
        arLocation = Location.getLocation(place: arrival)
        //arLocation = Location(name: arrival.wrappedValue, latitude: arPoint.0, longitude: arPoint.1)
        
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: arLocation.latitude, longitude: arLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    var locations = [arLocation, baseLocation]
    
    var body: some View {
        ZStack {
            VStack {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapPin(coordinate: location.coordinate)
                }
            }
        }
    }
}
