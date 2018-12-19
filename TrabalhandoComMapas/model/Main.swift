//
//	Main.swift
//
//	Create by Anderson Soares on 12/12/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Main : NSObject, NSCoding{

	var humidity : Int!
	var pressure : Int!
	var temp : Float!
	var tempMax : Float!
	var tempMin : Float!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		humidity = json["humidity"].intValue
		pressure = json["pressure"].intValue
		temp = json["temp"].floatValue
		tempMax = json["temp_max"].floatValue
		tempMin = json["temp_min"].floatValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		let dictionary = [String:Any]()
		if humidity != nil{
			dictionary["humidity"] = humidity
		}
		if pressure != nil{
			dictionary["pressure"] = pressure
		}
		if temp != nil{
			dictionary["temp"] = temp
		}
		if tempMax != nil{
			dictionary["temp_max"] = tempMax
		}
		if tempMin != nil{
			dictionary["temp_min"] = tempMin
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         humidity = aDecoder.decodeObject(forKey: "humidity") as? Int
         pressure = aDecoder.decodeObject(forKey: "pressure") as? Int
         temp = aDecoder.decodeObject(forKey: "temp") as? Float
         tempMax = aDecoder.decodeObject(forKey: "temp_max") as? Float
         tempMin = aDecoder.decodeObject(forKey: "temp_min") as? Float

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if humidity != nil{
			aCoder.encode(humidity, forKey: "humidity")
		}
		if pressure != nil{
			aCoder.encode(pressure, forKey: "pressure")
		}
		if temp != nil{
			aCoder.encode(temp, forKey: "temp")
		}
		if tempMax != nil{
			aCoder.encode(tempMax, forKey: "temp_max")
		}
		if tempMin != nil{
			aCoder.encode(tempMin, forKey: "temp_min")
		}

	}

}