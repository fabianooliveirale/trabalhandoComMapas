//
//  MapUmViewController.swift
//  Trabalhando com mapas
//
//  Created by Anderson Soares on 10/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import UIKit
import MapKit

class MapUmViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude: CLLocationDegrees = -23.586974
        let longitude: CLLocationDegrees = -46.657355
        
        let latitudeDelta = 0.0275
        let longitudeDelta =  0.0275
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        
        let region = MKCoordinateRegion(center: localizacao, span: span)
        
        map.setRegion(region, animated: true)

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
