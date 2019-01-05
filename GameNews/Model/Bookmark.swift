//
//  Bookmark.swift
//  GameNews
//
//  Created by Miguel Santos on 29/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation
import RealmSwift

class Bookmark: Object {
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var date = NSDate()

    @objc dynamic public private(set) var title = ""
    @objc dynamic public private(set) var imageUrl = ""
    @objc dynamic public private(set) var url = ""
    @objc dynamic public private(set) var pulse_source = ""
    @objc dynamic public private(set) var publish_date_milliseconds = ""
    @objc dynamic public private(set) var summary = ""
    
    //@objc dynamic public private(set) var pulse = Pulse()


    override class func primaryKey() -> String {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["pace", "date", "duration"]
    }

    convenience init(pulse: Pulse) {
        self.init()
        
        self.date = NSDate()
        self.id = pulse.Id
        self.title = pulse.Title
        self.imageUrl = pulse.ImageUrl
        self.url = pulse.Url
        self.pulse_source = pulse.Source
        self.publish_date_milliseconds = pulse.PublishDate
        self.summary = pulse.Summary
    }
    
    static func addBookmarkToRealm(pulse: Pulse) {
        REALM_QUEUE.async {
            let run = Bookmark(pulse: pulse)
            do {
                let realm = try Realm(configuration: RealmConfig.rundataConfig)
                try realm.write {
                    realm.add(run)
                    try realm.commitWrite()
                }
            } catch {
                debugPrint("Error adding pulse to realm")
            }
        }
    }
    
    static func getAllBookmarks() -> Results<Bookmark>? {
        do {
            let realm = try Realm(configuration: RealmConfig.rundataConfig)
            var runs = realm.objects(Bookmark.self)
            runs = runs.sorted(byKeyPath: "date", ascending: true)
            
            return runs
            
        } catch {
            return nil
        }
    }
    
}
