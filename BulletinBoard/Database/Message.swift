//
//  Message.swift
//  BulletinBoard
//
//  Created by HsinHung on 12/27/15.
//  Copyright © 2015 bulletin board. All rights reserved.
//

import Cocoa

public class Message: NSObject {

    var fromValue: String
    var timeValue: String
    var imageUrlValue: String
    var contentValue: String

    init(from: String, url: String, content: String, time: String) {
        fromValue = from
        imageUrlValue = url
        contentValue = content
        timeValue = time
    }

    public override func isEqual(object: AnyObject?) -> Bool {
        let message = object as! Message

        let selfString = fromValue + timeValue + imageUrlValue + contentValue
        let anotherString = message.getFrom() + message.getTimestamp() + message.getimageUrl() + message.getContent()
        return selfString == anotherString
    }

    func getTimestamp() -> String {
        return self.timeValue
    }

    public func getFrom() -> String {
        return self.fromValue
    }

    public func getimageUrl() -> String {
        return self.imageUrlValue
    }

    public func getContent() -> String {
        return self.contentValue
    }
    public func toString() -> String {
        return contentValue + " " + imageUrlValue
    }

    public static func toDictionary(list : [String: Message]) -> [String: [String: String]] {
        var dictionaryList = [String: [String: String]]()

        let keys = Array(list.keys)

        for key in keys {
            let content = list[key]

            let message = [
                "from" : content!.getFrom(),
                "imageUrl": content!.getimageUrl(),
                "content" : content!.getContent(),
                "time" : content!.getTimestamp()
            ]
            dictionaryList[key] = message
        }

        return dictionaryList
    }

    public static func fromDictionary(data: [String: [String: String]]) -> [String: Message] {
        var messageList = [String: Message]()

        let keys = Array(data.keys)

        for key in keys {
            let content = data[key]
            let message = Message(
                from: content!["from"] ?? String(),
                url: content!["imageUrl"]!,
                content: content!["content"]!,
                time: content!["time"] ?? String()
            )

            messageList[key] = message
        }

        return messageList
    }
}
