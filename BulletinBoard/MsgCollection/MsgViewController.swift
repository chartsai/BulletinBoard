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
import MultipeerConnectivity

class MsgViewController: NSViewController, NSCollectionViewDataSource, MessagingService {
    @IBOutlet weak var collectionView: NSCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
    }

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMessageNumber
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let item: SingleItem = collectionView.makeItemWithIdentifier("SingleItem", forIndexPath: indexPath) as! SingleItem
        item.contentTextView.string = messages[indexPath.item].contentValue
        // representedObject can keep to do other thing.
        return item
    }

    func recieveAdditionalMessage(message: Message) {
        dbManager.put(message)
        dbManager.save()

        messages.append(message)
        currentMessageNumber += 1

        refreshMessageBoard()
    }

    func tendToDeleteMessage(message: Message) {
        var found = false
        for index in 0...messages.count {
            if messages[index] == message {
                messages.removeAtIndex(index)
                found = true
                break
            }
        }

        guard found == true else {
            return
        }
        currentMessageNumber -= 1

        dbManager.delete(message)
        dbManager.save()

        refreshMessageBoard()
    }

    func refreshMessageBoard() {
        collectionView.reloadData()
    }


    func didReceiveTranscript(transcript: Transcript) {
        print(transcript.message)

        let auther = transcript.peerID.displayName
        let content = transcript.message
        let url = transcript.imageUrl?.absoluteString ?? ""

        let message = Message(from: auther, url: url, content: content)
        recieveAdditionalMessage(message)
    }

    var dbManager: AdaptedDbManager = AdaptedDbManager()
    var peerConnect: PeerConnect
    var currentMessageNumber: Int
    var messages: [Message]

    required init?(coder: NSCoder) {
        peerConnect = PeerConnect.init()

        let messageDic: [String: Message] = dbManager.getAll()
        currentMessageNumber = messageDic.count
        messages = Array(messageDic.values)
        super.init(coder: coder)

        peerConnect.messageDelegate = self
        peerConnect.serviceStart()
    }
}
