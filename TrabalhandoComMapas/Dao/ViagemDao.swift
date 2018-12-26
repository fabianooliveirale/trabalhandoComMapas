//  ViagemDao.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 21/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import Foundation

class ViagemDao {
    
    var viagens: [Viagem] = []
    
    func salva(viagem: Viagem){
        
            viagens = list()
            viagens.append(viagem)
            print(viagem.latitude + viagem.local + viagem.longitude)
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: viagens)
            userDefaults.set(encodedData, forKey: "viagem")
            userDefaults.synchronize()
    }
    
    func list() -> [Viagem]{
        let userDefaults = UserDefaults.standard
        if let decoded = userDefaults.object(forKey: "viagem"){
            let array = try NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! [Viagem]
            //print(array.count)
            return array
        } else {
            print("RETURN NULL")
            return []
        }
    }
    
    func remover(index: Int){
        viagens = list()
        viagens.remove(at: index)
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: viagens)
        userDefaults.set(encodedData, forKey: "viagem")
        userDefaults.synchronize()
    }
    
}

    




