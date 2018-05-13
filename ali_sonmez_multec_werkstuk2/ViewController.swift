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
    let name: String
    let position: Locatie?
}

struct Locatie:Decodable {
    let lat: Double
    let lng: Double
}

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet var lblTitel: UILabel!
    @IBAction func btnNed(_ sender: UIButton) {
        let language = Bundle.main.path(forResource: "nl", ofType: "lproj")
        let nl = Bundle.init(path: language!)! as Bundle
        lblTitel.text = nl.localizedString(forKey: "Hello", value: nil, table: nil)
    }
    @IBAction func btnEn(_ sender: UIButton) {
        let language = Bundle.main.path(forResource: "en", ofType: "lproj")
        let nl = Bundle.init(path: language!)! as Bundle
        lblTitel.text = nl.localizedString(forKey: "Hello", value: nil, table: nil)
    }
    @IBAction func btnFr(_ sender: UIButton) {
        let language = Bundle.main.path(forResource: "fr", ofType: "lproj")
        let nl = Bundle.init(path: language!)! as Bundle
        lblTitel.text = nl.localizedString(forKey: "Hello", value: nil, table: nil)
    }
    
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.10, longitudeDelta: 0.10)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
}
