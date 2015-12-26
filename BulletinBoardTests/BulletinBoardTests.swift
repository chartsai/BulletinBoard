//
//  BulletinBoardTests.swift
//  BulletinBoardTests
//
//  Created by CHA-MBP on 2015/12/26.
//  Copyright © 2015年 bulletin board. All rights reserved.
//

import XCTest
@testable import BulletinBoard

class BulletinBoardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        testGetPut()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }


    func testGetPut() {
        let dbManager = AdaptedDbManager()

        let dictionaryList = [
            "ID_001": [
                "imageUrl" : "image_01",
                "content"  : "content_01"
            ],
            "ID_002": [
                "imageUrl" : "image_02",
                "content"  : "content_02"
            ],
            "ID_003": [
                "imageUrl" : "image_03",
                "content"  : "content_03"
            ]
        ]
        let messageList = Message.fromDictionary(dictionaryList)
        print(messageList)

        let keys = Array(messageList.keys)

        for key in keys {
            dbManager.put(key, content: messageList[key]!)
        }
        dbManager.save()
        print("size : " + String(dbManager.getMessageSize()))

        dbManager.sync()
        print(dbManager.getAll())
        print(dbManager.get("ID_001"))

        dbManager.delete("ID_002")
        print(dbManager.getAll())

//        dbManage.put(["First", "Second", "Third"])
//        var data = dbManage.get()
//        print(data);
//
//        dbManage.add(["Fourth, Fifth"])
//        data = dbManage.get()
//        print(data)
    }
}
