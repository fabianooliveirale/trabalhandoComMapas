//
//  Viagem.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 21/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import Foundation


class Viagem: NSObject, NSCoding{
    
    var local:String
    var latitude:String
    var longitude:String
    
    init(local:String = "", latitude:String = "", longitude:String = ""){
        self.local = local
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if local != nil{
            dictionary["local"] = local
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        return dictionary
    }
    
    @objc required init(coder aDecoder: NSCoder)
    {
        local = (aDecoder.decodeObject(forKey: "local") as? String)!
        latitude = (aDecoder.decodeObject(forKey: "latitude") as? String)!
        longitude = (aDecoder.decodeObject(forKey: "longitude") as? String)!
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if local != nil{
            aCoder.encode(local, forKey: "local")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
    }
    
}
