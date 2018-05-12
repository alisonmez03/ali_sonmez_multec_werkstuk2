//
//  ViewController.swift
//  ali_sonmez_multec_werkstuk2
//
//  Created by Ali Sönmez on 11/05/2018.
//  Copyright © 2018 Ali Sönmez. All rights reserved.
//

import UIKit
import MapKit

struct Villo:Decodable {
    let number: Int
    let name: String
}

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        centerMapOnLocation(location: initialLocation)
            
            let artwork = Artwork(title: "King David Kalakaua",
                                  locationName: "Waikiki Gateway Park",
                                  discipline: "Sculpture",
                                  coordinate: CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444))
        
        mapView.addAnnotation(artwork)
        
        let url = "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale"
        let urlObj = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
            
            do{
                let Villobxl = try JSONDecoder().decode([Villo].self, from: data!)
                
                for villo in Villobxl {
                    print(villo.number , villo.name)
                }
                
            } catch{
                print("Shit Error")
            }
            }.resume()
        }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

