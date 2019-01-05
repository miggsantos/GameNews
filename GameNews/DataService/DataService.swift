//
//  DataService.swift
//  GameNews
//
//  Created by Miguel Santos on 04/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

extension UInt64 {
    
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
    
}

class DataService {
    
    private var base_url = ""
    private var headers: HTTPHeaders = ["Accept":"application/json", "user-key": ""]
    private let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )

    private static var instance: DataService?
    
    public static func getInstance() -> DataService{
    
        if(instance == nil){
            instance = DataService()
        }
    
        return instance!
    }
    
    private init(){
        
        print("DataService init")
        
        base_url = ConfigUtil.Read_IGDB_Configs(key: "IGDB_URL")
        let key = ConfigUtil.Read_IGDB_Configs(key: "IGDB_KEY")
        headers["user-key"] = key
    }
    
    func getNews(offset: Int, completion: @escaping (_ result: [Pulse]) -> Void) {
        
        var pulseList = [Pulse]()

        let url = base_url + IGDB_API_GET_PULSES.replacingOccurrences(of: "{OFFSET}", with: String(pulses.count) )
        
        Alamofire.SessionManager.default.requestWithCacheOrLoad(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { (respData) in

        //Alamofire.request(base_url + IGDB_API_GET_PULSES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { (respData) in
    
            switch respData.result {
            case .success( _):
                
                
                //respData.response?.allHeaderFields["x"]
                
                    let json = JSON((data: respData.result.value!))
                    for item in json.arrayValue {
                        
                        let sourceId = item["pulse_source"].stringValue
                        
                        let p = Pulse(id: item["id"].stringValue, title: item["title"].stringValue, imageUrl: item["image"].stringValue, url: "", source: PULSE_SOURCES[sourceId] ?? "", publishDate: item["published_at"].stringValue, summary: item["summary"].stringValue )
                        
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
    
    func getImage(imageUrl: String, pageType: PageType, completion: @escaping(_ result: UIImage?) -> Void) {
        
        Alamofire.request(imageUrl).responseImage { response in
            //debugPrint(response)
            switch response.result {
                case .success( _):
                    
                    guard var image = response.result.value else { return }
 
                    var resize: CGSize?
                    
                    switch pageType {
                    case .News:
                        resize = IMAGE_SIZE_PULSE_NEWS
                        break
                    case .Article:
                        resize = IMAGE_SIZE_PULSE_ARTICLE
                        break
                    }
                    
                    if(resize != nil) {

                        image = image.af_imageAspectScaled(toFill: resize!)
                    }
                    
                    completion(image)
                    self.cache(image, for: "\(imageUrl)\(pageType)")
 
                    break;
                case .failure(let error):
                    print("Request image failed with error: \(error)")
                    completion(nil)
                    break;
                
            }
   
        }
    }
    
    
    //MARK: = Image Caching
    
    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
    

}


