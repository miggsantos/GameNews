//
//  Pulse.swift
//  GameNews
//
//  Created by Miguel Santos on 04/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation

enum PageType {
    case News
    case Article
}


class Pulse {
    
    private var id: String
    private var title: String
    private var imageUrl: String
    private var url: String
    private var pulse_source: String
    private var publish_date_milliseconds: String
    private var summary: String
    
    
    
    
    init(id: String, title: String, imageUrl: String, url:String, source:String, publishDate:String, summary:String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.url = url
        self.pulse_source = source
        self.publish_date_milliseconds = publishDate
        self.summary = summary
    }
    
    var PublishDate: String {
        get {
            print("publish_date_milliseconds=\(publish_date_milliseconds)" )
            if(publish_date_milliseconds == ""){
                return ""
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM, h:mm"

            let date = Date(timeIntervalSince1970: (Double(publish_date_milliseconds)! / 1000.0 ))
            print("date=\(formatter.string(from: date))" )
            return formatter.string(from: date)


            
        }
    }
    
    
    
    
    
    var Id: String {
        get {
            return id
        }
        set {
            self.id = newValue
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
    
    var ImageUrl: String {
        get {
            return imageUrl
        }
        set {
            self.imageUrl = newValue
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
