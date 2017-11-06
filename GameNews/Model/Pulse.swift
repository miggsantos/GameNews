//
//  Pulse.swift
//  GameNews
//
//  Created by Miguel Santos on 04/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation

class Pulse {
    
    private var id: String
    private var title: String
    private var image: String
    private var url: String
    private var pulse_source: String
    private var publish_date_milliseconds: String
    private var summary: String
    
    init(id: String, title: String, imageUrl: String, url:String, source:String, publishDate:String, summary:String) {
        self.id = id
        self.title = title
        self.image = imageUrl
        self.url = url
        self.pulse_source = source
        self.publish_date_milliseconds = publishDate
        self.summary = summary
    }
    
    var PublishDate: String {
        get {
            
            if(publish_date_milliseconds == ""){
                return ""
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM, h:mm"

            let date = Date(timeIntervalSince1970: (Double(publish_date_milliseconds)! / 1000.0 ))
            return formatter.string(from: date)

        }
    }
    
    var Title: String {
        get {
            return title
        }
        set {
            self.title = newValue
        }
    }
    
    var Image: String {
        get {
            return image
        }
        set {
            self.image = newValue
        }
    }
    
    var Url: String {
        get {
            return url
        }
        set {
            self.url = newValue
        }
    }
    
    var Source: String {
        get {
            return pulse_source
        }
        set {
            self.pulse_source = newValue
        }
    }
    
    var Summary: String {
        get {
            return summary
        }
        set {
            self.summary = newValue
        }
    }
    
}
