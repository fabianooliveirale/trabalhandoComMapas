//
//  File.swift
//  Trabalhando com mapas
//
//  Created by Anderson Soares on 11/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire



class ClimaApi {
    
    private static let rota = "https://api.hgbrasil.com/"
    //private static let woeid = "455822"
    
    static func climaDetalhes(woeid: String, completion: @escaping (_ response: ClimaJson) -> Void) {
        if let url = URL(string: rota+"weather?woeid="+woeid){
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                response.debugLog()
                
                let status:Int = response.response?.statusCode ?? 0
                //print("STATUS \(String(describing: status))")
                
                let json = JSON(response.result.value as Any)
                let object = ClimaJson(fromJson: json)
                
                print("******************************")
                print(object.results.cityName)
                print("******************************")
                completion(object)
        }
    }
 }
}
