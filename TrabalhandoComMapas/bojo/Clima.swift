//
//  File.swift
//  Trabalhando com mapas
//
//  Created by Anderson Soares on 11/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import Foundation


class Clima: NSObject, NSCoding, Codable{
    
    var id: String!
    var lon: String!
    var lat: String!
    var temp: String!
    var pressure: String!
    var speed: String!
    var deg: String!
    var name: String!
    
    init(id: String = "", lon: String = "", lat: String = "", temp: String = "",
                  pressure: String = "", speed: String = "", deg: String = "", name: String = "") {
        
        self.id = id
        self.lon = lon
        self.lat = lat
        self.temp = temp
        self.pressure = pressure
        self.speed = speed
        self.deg = deg
        self.name = name
        
    }
    
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if lon != nil{
            dictionary["lon"] = lon
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if temp != nil{
            dictionary["temp"] = temp
        }
        if pressure != nil{
            dictionary["pressure"] = pressure
        }
        if speed != nil{
            dictionary["speed"] = speed
        }
        if deg != nil{
            dictionary["deg"] = deg
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }
    
    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lon != nil{
            aCoder.encode(lon, forKey: "lon")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if temp != nil{
            aCoder.encode(temp, forKey: "temp")
        }
        if pressure != nil{
            aCoder.encode(pressure, forKey: "pressure")
        }
        if speed != nil{
            aCoder.encode(speed, forKey: "speed")
        }
        if deg != nil{
            aCoder.encode(deg, forKey: "deg")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String
        lon = aDecoder.decodeObject(forKey: "lon") as? String
        lat = aDecoder.decodeObject(forKey: "lat") as? String
        temp = aDecoder.decodeObject(forKey: "temp") as? String
        pressure = aDecoder.decodeObject(forKey: "pressure") as? String
        speed = aDecoder.decodeObject(forKey: "speed") as? String
        deg = aDecoder.decodeObject(forKey: "deg") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    
    
    
    
    
}
