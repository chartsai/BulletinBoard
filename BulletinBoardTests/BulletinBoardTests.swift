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
                "from" : "user_01",
                "imageUrl" : "image_01",
                "content"  : "content_01",
                "time" : "123"
            ],
            "ID_002": [
                "from" : "user_02",
                "imageUrl" : "image_02",
                "content"  : "content_02",
                "time" : "456"
            ],
            "ID_003": [
                "from" : "user_03",
                "imageUrl" : "image_03",
                "content"  : "content_03",
                "time" : "789"
            ]
        ]
        let messageList = Message.fromDictionary(dictionaryList)
        print(messageList)

        let keys = Array(messageList.keys)

        for key in keys {
            dbManager.put(messageList[key]!)
        }
        dbManager.save()
        print("size : " + String(dbManager.getMessageSize()))

        dbManager.sync()
        print(dbManager.getAll())
        print(dbManager.get("ID_001"))

        dbManager.delete(dbManager.get("ID_001"))
        print(dbManager.getAll())
        print("size : " + String(dbManager.getMessageSize()))

//        dbManage.put(["First", "Second", "Third"])
//        var data = dbManage.get()
//        print(data);
//
//        dbManage.add(["Fourth, Fifth"])
//        data = dbManage.get()
//        print(data)
    }
}
