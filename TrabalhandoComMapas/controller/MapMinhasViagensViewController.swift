//
//  MapMinhasViagensViewController.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 21/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import UIKit
import MapKit

class MapMinhasViagensViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    var gerenciadorlocal = CLLocationManager()
    var viagens: [Viagem] = []
    var vaigem: Viagem!
    var indiceSelecionado: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLocation()
        let gesto = UILongPressGestureRecognizer(target: self, action: #selector(MapMinhasViagensViewController.marcar(gesture:)))
        gesto.minimumPressDuration = 2
        map.addGestureRecognizer(gesto)
        print(vaigem.local + String(indiceSelecionado))
        // Do any additional setup after loading the view.
    }
    
    // FUNC responsavel pelo click segure por 2 segundos e marca o mapa
    @objc func marcar (gesture: UIGestureRecognizer){
        
        if gesture.state == UIGestureRecognizer.State.began {
            
            let pontoSelecionado = gesture.location(in: self.map)
            let coordenadas = map.convert(pontoSelecionado, toCoordinateFrom: self.map)
             let localizacao: CLLocation = CLLocation(latitude: coordenadas.latitude, longitude: coordenadas.longitude)
                
                var lo = "Endereço não encontrado!"
                CLGeocoder().reverseGeocodeLocation(localizacao) { (local, erro) in
                    if erro == nil {
                        
                        if let dadosLocal = local?.first {
                            if let name = dadosLocal.name {
                                lo = name
                            }else if let end = dadosLocal.thoroughfare{
                                lo = end
                            }
                        }
                        
                        let v : Viagem = Viagem(local: String(lo), latitude: String(coordenadas.latitude), longitude: String(coordenadas.longitude))
                        let dao:ViagemDao = ViagemDao()
                        dao.salva(viagem: v)
                        print(dao.list().count)
                        
                        for a in dao.list(){
                            print("Local: " + a.local + "  Latitude: "+a.latitude+"  Longitude: "+a.longitude)
                        }
                        
                        let anotacao = MKPointAnnotation()
                        anotacao.coordinate.latitude = coordenadas.latitude
                        anotacao.coordinate.longitude = coordenadas.longitude
                        anotacao.title = lo
                        //anotacao.subtitle = "subTitulo"
                        
                        self.map.addAnnotation(anotacao)
                    }else{
                        print(erro)
                    }
                
            } //print("GesturePrint INICIAAA") // inicia
        }
    }
    
    func configLocation(){
        gerenciadorlocal.delegate = self
        gerenciadorlocal.desiredAccuracy = kCLLocationAccuracyBest // melhor precisão possivel
        gerenciadorlocal.requestWhenInUseAuthorization() // info.plist > Required Device Capabilities > information property list > location When
        gerenciadorlocal.startUpdatingLocation()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super .didReceiveMemoryWarning()
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

}
