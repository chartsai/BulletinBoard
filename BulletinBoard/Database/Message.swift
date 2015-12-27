//
//  Message.swift
//  BulletinBoard
//
//  Created by HsinHung on 12/27/15.
//  Copyright © 2015 bulletin board. All rights reserved.
//

import Cocoa

public class Message: NSObject {

    var keyValue = ""
    var imageUrlValue = ""
    var contentValue = ""

    public func setKey(key : String) {
        self.keyValue = key
    }

    public func setimageUrl(url : String) {
        self.imageUrlValue = url
    }

    public func setContent(content : String) {
        self.contentValue = content
    }

    public func getKey() -> String {
        return self.keyValue
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
                "imageUrl": content!.getimageUrl(),
                "content" : content!.getContent()
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

            let message = Message()
            message.setKey(key)
            message.setimageUrl(content!["imageUrl"]!)
            message.setContent(content!["content"]!)

            messageList[key] = message
        }

        return messageList
    }
}
