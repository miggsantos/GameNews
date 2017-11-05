//
//  DataService.swift
//  GameNews
//
//  Created by Miguel Santos on 04/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
    
    private var base_url = ""
    private var headers: HTTPHeaders = ["Accept":"application/json", "user-key": ""]
    

    static let instance = DataService()
    
    init(){
        
        print("DataService init")
        
        base_url = ConfigUtil.Read_IGDB_Configs(key: "IGDB_URL")
        let key = ConfigUtil.Read_IGDB_Configs(key: "IGDB_KEY")
        headers["user-key"] = key
    }
    
    func getNews(completion: @escaping (_ result: [Pulse]) -> Void) {
        
        var pulseList = [Pulse]()
        
        Alamofire.request(base_url + IGDB_API_GET_PULSES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { (respData) in
    
            switch respData.result {
            case .success( _):
                
                    let json = JSON((data: respData.result.value!))
                    for item in json.arrayValue {
                        
                        let sourceId = item["pulse_source"].stringValue
                        
                        let p = Pulse(id: item["id"].stringValue, title: item["title"].stringValue, imageUrl: item["image"].stringValue, url: item["url"].stringValue, source: PULSE_SOURCES[sourceId] ?? "", publishDate: item["published_at"].stringValue )
                        
                        pulseList.append(p)
                    }
                    break;
                
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    break;
            }
            
            completion(pulseList)
        }
    }

}


