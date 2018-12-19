//
//  OndeEstouViewController.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 19/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import UIKit
import MapKit

class OndeEstouViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBOutlet weak var lon: UILabel!
    @IBOutlet weak var lat: UILabel!
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
            
            CLGeocoder().reverseGeocodeLocation(localUser) { (detalhesLocal, erro) in
                if erro == nil {
                    
                    if let dados = detalhesLocal?.first {
                        // print(dados)
                        if let end = dados.thoroughfare {
                            if let num = dados.subThoroughfare {
                                self.end.text = end+", "+num
                            }
                        }
                    }
                }else{
                    print(erro)
                }
            }
            
            lat.text = String(localUser.coordinate.latitude)
            lon.text = String(localUser.coordinate.longitude)
            if localUser.speed > 0 {
                speed.text = String(localUser.speed)
            }else{
                speed.text = "0"
            }
     
            
        }
        //print(locations)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            let alertController = UIAlertController(title: "Permissão de localização", message: "Necessário permissão para acesso!", preferredStyle: .alert)
            
            let acaoConfig = UIAlertAction(title: "Abrir configurações", style: .default) { (acaoConfig) in
                if let configuracoes = NSURL.init(string:UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(configuracoes as URL)
                }
            }
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfig)
            alertController.addAction(acaoCancelar)
            
            present( alertController, animated: true, completion: nil)
        }
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
