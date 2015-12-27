//
//  MsgViewController.swift
//  BulletinBoard
//
//  Created by LEE ZHE YU on 2015/12/27.
//  Copyright © 2015年 bulletin board. All rights reserved.
//

import Cocoa

class MsgViewController: NSViewController, NSCollectionViewDataSource {
    @IBOutlet weak var collectionView: NSCollectionView!

    var strings = ["1", "2", "3", "4", "5", "6", "7"].sort()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
    }

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return strings.count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItemWithIdentifier("SingleItem", forIndexPath: indexPath)
        item.representedObject = ItemObject(title: strings[indexPath.item])
        print(strings[indexPath.item]);
        return item
    }
}
