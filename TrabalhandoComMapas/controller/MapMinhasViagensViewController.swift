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
    var controle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLocation()
        let gesto = UILongPressGestureRecognizer(target: self, action: #selector(MapMinhasViagensViewController.marcar(gesture:)))
        gesto.minimumPressDuration = 2
        map.addGestureRecognizer(gesto)
        if let v: Viagem = vaigem {
            
            print(v.local + String(indiceSelecionado))
            
        }
        
        if controle == "lista" {
            self.anotacao(viagem: vaigem)
        }
    }
    
    
    
    
    func anotacao (viagem : Viagem){
        
        if let lViagem:String = viagem.local {
            if let latViagem:String = viagem.latitude{
                if let lonViagem:String = viagem.longitude{
                    
                    if let lat = Double(latViagem){
                        if let lon = Double(lonViagem){
                            
                            // vai até local de destino
                            
                            let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
                            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                            
                            let region = MKCoordinateRegion(center: localizacao, span: span)
                            map.setRegion(region, animated: true)
                            
                            // COLOCA uma marquinha no mapa
                            
                            let anotacao = MKPointAnnotation()
                            anotacao.coordinate.latitude = lat
                            anotacao.coordinate.longitude = lon
                            anotacao.title = lViagem
                            //anotacao.subtitle = "subTitulo"
                            
                            self.map.addAnnotation(anotacao)
                            
                            
                        }
                    }
                }
            }
        }
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if controle != "lista" {
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
        }
        
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
