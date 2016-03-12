//
//  Maps.swift
//  Weather
//
//  Created by Quentin Logie on 3/3/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftLoader
import RealmSwift
import GoogleMaps
import CoreLocation

class Maps:UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{
    let locationManager = CLLocationManager()
    var url: String = "http://api.openweathermap.org/data/2.5/weather"
    var appId: String = "4d1e230aba90addc95e3ea4bbb9a08cd"
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        var arrayMarker:[GMSMarker] = []
        let realm = try! Realm()
        let fav = realm.objects(Favorite)
        for fa in fav
        {
            let position = CLLocationCoordinate2DMake(Double(fa.lat), Double(fa.long))
            let marker = GMSMarker(position: position)
            marker.title = fa.city
            marker.map = self.mapView
            arrayMarker.append(marker)
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        let urlWeather = url + "?lat=" + String(marker.position.latitude) + "&lon=" + String(marker.position.latitude) + "&appid=" + appId
        WSController.getWeather(urlWeather) { weather, error in
            self.cityLabel.text = marker.title! + ", " + Temperature.kelvinFormatInDegre(weather!.main.temp) + " : " + weather!.weather[0].main
            
        }
        return true
    }
    
}

