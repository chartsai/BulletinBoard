//
//  DatabaseManager.swift
//  BulletinBoard
//
//  Created by HsinHung on 12/26/15.
//  Copyright © 2015 bulletin board. All rights reserved.
//

import Cocoa

public class AdaptedDbManager {
    public static func get() -> [String] {
        return NSUserDefaults.standardUserDefaults().objectForKey("MessageData") as? [String] ?? [String]()
    }

    public static func put(data: [String]) {
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "MessageData")
    }

    //public func add(data: [String]) {
    //    NSUserDefaults.standardUserDefaults().insertValue(data, inPropertyWithKey: "MessageData")
    //}
}

