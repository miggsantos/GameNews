//
//  ConfigUtil.swift
//  GameNews
//
//  Created by Miguel Santos on 05/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation

class ConfigUtil{
    
    static func Read_IGDB_Configs(key: String) -> String {
        
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                return dict[key] as! String
            }
        }
        
        return ""
        
    }
    
    
}
