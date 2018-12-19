//
//  ClimaJsonDao.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 14/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import SVProgressHUD

class ClimaJsonDao{
    
    var climas: [ClimaJson] = []
    var climasUpdate: [ClimaJson] = []
    
    func salvar(clima: ClimaJson){
        climas = listar()
        if let c: Array<ClimaJson> = climas{
           climas.append(clima)
        }
        
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: climas)
        userDefaults.set(encodedData, forKey: "climaJson")
        userDefaults.synchronize()
    }
    
    func listar() -> Array<ClimaJson> {
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "climaJson") as! Data
        let array = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [ClimaJson]
        return array
    }
    
    func remove(index: Int) {
        climas = listar()
        climas.remove(at: index)
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: climas)
        userDefaults.set(encodedData, forKey: "climaJson")
        userDefaults.synchronize()
    }
        
    
}
