//
//  ViewController.swift
//  ali_sonmez_multec_werkstuk2
//
//  Created by Ali Sönmez on 11/05/2018.
//  Copyright © 2018 Ali Sönmez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct Villo:Decodable {
    let number: Int
    let name: String
    let position: Locatie?
}

struct Locatie:Decodable {
    let lat: Double
    let lng: Double
}

class ViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let url = "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale"
        let urlObj = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
            
            do{
                let Villobxl = try JSONDecoder().decode([Villo].self, from: data!)
                
                for villo in Villobxl {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: (villo.position?.lat)!, longitude: (villo.position?.lng)!)
                    annotation.title = villo.name
                    
                    self.mapView.addAnnotation(annotation)
                }
            } catch{
                print("Shit Error")
            }
        }.resume()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
}
