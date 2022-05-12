//
//  testMap.swift
//  SmartScheduler
//
//  Created by seyonee on 2022/05/13.
//

import UIKit

class ViewController: UIViewController, MTMapViewDelegate {
    var mapView: MTMapView?
    @IBOutlet var kakaoMapTest: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MTMapView(frame: kakaoMapTest.bounds)
        
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            
            kakaoMapTest.addSubview(mapView)
        }
    }
}
