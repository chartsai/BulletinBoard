//
//  MsgViewController.swift
//  BulletinBoard
//
//  Created by LEE ZHE YU on 2015/12/27.
//  Copyright © 2015年 bulletin board. All rights reserved.
//

import Foundation
import AppKit
import Cocoa

@objc class MsgViewController: NSViewController, NSCollectionViewDataSource, MessagingService {
    @IBOutlet weak var collectionView: NSCollectionView!

//    var strings = ["1", "2", "3", "4", "5", "6", "7"].sort()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
    }

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
//        return strings.count
        return number
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItemWithIdentifier("SingleItem", forIndexPath: indexPath)
//        item.representedObject = ItemObject(title: strings[indexPath.item])
        item.representedObject = ItemObject(message: messages[indexPath.item])
//        print(strings[indexPath.item]);
        print(messages[indexPath.item])
        return item
    }

    @objc func didReceiveTranscript(transcript: Transcript) {
        print(transcript.message)
    }

    var dbManager: AdaptedDbManager = AdaptedDbManager()
    var peerConnect: PeerConnect
    var number: Int
    var messages: [Message]

    required init?(coder: NSCoder) {
        peerConnect = PeerConnect.init()

        let messageDic: [String: Message] = dbManager.getAll()
        number = messageDic.count
        messages = Array(messageDic.values)
        super.init(coder: coder)

        peerConnect.messageDelegate = self
        peerConnect.serviceStart()
    }
}
