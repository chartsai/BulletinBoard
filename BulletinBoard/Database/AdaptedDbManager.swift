//
//  DatabaseManager.swift
//  BulletinBoard
//
//  Created by HsinHung on 12/26/15.
//  Copyright © 2015 bulletin board. All rights reserved.
//

import Cocoa

public class AdaptedDbManager {

    var messageList = [String: Message]()

    init() {
        let dictionaryList = (NSUserDefaults.standardUserDefaults().dictionaryForKey("MessageData") as? [String: [String: String]]) ?? [String: [String: String]]()

        messageList = Message.fromDictionary(dictionaryList)
    }

    public func getAll() -> [String: Message] {
        return messageList
    }

    public func get(key: String) -> Message {
        return messageList[key]!
    }

    public func put(content: Message) {
        put(content.getFrom(), url: content.getimageUrl(), content: content.getContent())
    }

    public func put(from: String, url: String, content: String) {
        put(from, url: url, content: content, time: getTimestampString())
    }

    public func put(from: String, url: String, content: String, time: String) {
        let message = Message(
            from: from,
            url: url,
            content: content,
            time: time
        )
        messageList[time] = message
    }

    public func delete(key: String) {
        messageList.removeValueForKey(key)
    }

    public func delete(message: Message) {
        let sequence = messageList.enumerate()

        for element in sequence {
            if element.element.1.isEqual(message) {
                delete(element.element.0)
            }
        }
    }

    public func getMessageSize() -> Int {
        return messageList.keys.count
    }

    public func sync() {
        let dictionaryList = (NSUserDefaults.standardUserDefaults().dictionaryForKey("MessageData") as? [String: [String: String]]) ?? [String: [String: String]]()

        messageList = Message.fromDictionary(dictionaryList)
        print("sync : " + " " + String(messageList))
    }

    public func save() {
        print("save : " + " " + String(messageList))

        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(Message.toDictionary(messageList), forKey: "MessageData")
        userDefaults.synchronize()
    }
}

func getTimestampString() -> String {
    return String(NSDate().timeIntervalSince1970 * 1000)
}
