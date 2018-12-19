//
//  ClimaDao.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 13/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ClimaDao{
    

    var climas: [Clima] = []
    


    
    
    
     func salvar(clima: Clima){
        climas = listar()
        climas.append(clima)
        
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: climas)
        userDefaults.set(encodedData, forKey: "clima")
        userDefaults.synchronize()

    }
    
    func listar() -> Array<Clima> {
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "clima") as! Data
        let array = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Clima]
        return array
    }
    
    
 

//    func listar() -> Array<Clima>{
//
//        let dados = UserDefaults.standard.object(forKey: chave)
//
//        if dados != nil {
//            return dados as! Array<Clima>
//        }else{
//            return []
//        }
//
//    }
    
    
    
    
    func remove(index: Int) {
        
      //  climas = listar()
        //climas.remove(at: index)
        //UserDefaults.standard.set(climas, forKey: chave)
        
    }
    
    
}

