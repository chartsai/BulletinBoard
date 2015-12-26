//
//  DatabaseManager.swift
//  BulletinBoard
//
//  Created by HsinHung on 12/26/15.
//  Copyright © 2015 bulletin board. All rights reserved.
//

import Cocoa

public class AdaptedDbManager {
    public func get() -> [String] {
        return NSUserDefaults.standardUserDefaults().valueForKey("MessageData") as? [String] ?? [String]()
    }

    public func put(data: [String]) {
        NSUserDefaults.standardUserDefaults().setValue(data, forKey: "MessageData")
    }

    public func add(data: [String]) {
        var oldData = get()
        oldData.appendContentsOf(data)

        put(oldData)
    }
}

