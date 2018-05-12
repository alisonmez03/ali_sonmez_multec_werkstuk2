//
//  DetailleViewController.swift
//  ali_sonmez_multec_werkstuk2
//
//  Created by Ali Sönmez on 13/05/2018.
//  Copyright © 2018 Ali Sönmez. All rights reserved.
//

import UIKit

class DetailleViewController: UIViewController {

    
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var lblSubtitel: UILabel!
    @IBOutlet weak var lblCoordinaten: UILabel!
    
    var name = ""
    var subtitel = ""
    var lat = 0
    var lng = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitel.text = name
        lblSubtitel.text = subtitel
        lblCoordinaten.text = String(format: "Lat: %.6f // lon: %.6f", lat,lng)

    }

}
