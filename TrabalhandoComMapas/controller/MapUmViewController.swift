//
//  MapUmViewController.swift
//  Trabalhando com mapas
//
//  Created by Anderson Soares on 10/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import UIKit
import MapKit

class MapUmViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    var gerenciadorlocal = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorlocal.delegate = self
        gerenciadorlocal.desiredAccuracy = kCLLocationAccuracyBest // melhor precisão possivel
        gerenciadorlocal.requestWhenInUseAuthorization() // info.plist > Required Device Capabilities > information property list > location When
        gerenciadorlocal.startUpdatingLocation()
        // mainStoryBoard e clicar em user location direto no mapa
        
        /*let latitude: CLLocationDegrees = -23.586974
        let longitude: CLLocationDegrees = -46.657355
        
        let latitudeDelta = 0.0275
        let longitudeDelta =  0.0275
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        
        let region = MKCoordinateRegion(center: localizacao, span: span)
        
        map.setRegion(region, animated: true)
        
        
        let anotacao = MKPointAnnotation()
        anotacao.coordinate = localizacao
        anotacao.title = "TITULO"
        anotacao.subtitle = "subTitulo"
        
        map.addAnnotation(anotacao)*/

        
    }
    
    
    // atualiza conforme o usuario se move
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let localUser: CLLocation = locations.last{
            let latitude: CLLocationDegrees = localUser.coordinate.latitude
            let longitude: CLLocationDegrees = localUser.coordinate.longitude
            
            let latitudeDelta = 0.0275
            let longitudeDelta =  0.0275
            
            let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            
            let region = MKCoordinateRegion(center: localizacao, span: span)
            map.setRegion(region, animated: true)
        }
        print(locations)
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
