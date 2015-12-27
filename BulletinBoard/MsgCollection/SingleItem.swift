//
//  SingleItem.swift
//  BulletinBoard
//
//  Created by LEE ZHE YU on 2015/12/27.
//  Copyright © 2015年 bulletin board. All rights reserved.
//

import Cocoa

class ItemObject: NSObject {
    var title:String

    init(title:String) {
        self.title = title
    }
}

class SingleItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    // MARK: properties
    var itemObject:ItemObject? {
        return representedObject as? ItemObject
    }

    override var selected: Bool {
        didSet {
            (self.view as! SingleItemView).selected = selected
        }
    }
    override var highlightState: NSCollectionViewItemHighlightState {
        didSet {
            (self.view as! SingleItemView).highlightState = highlightState
        }
    }

    // MARK: outlets

    @IBOutlet weak var label: NSTextField!

    // MARK: NSResponder

    override func mouseDown(theEvent: NSEvent) {
        if theEvent.clickCount == 2 {
            print("Double click \(itemObject!.title)")
        } else {
            super.mouseDown(theEvent)
        }
        
    }

}

class SingleItemView: NSView {
    // MARK: properties
    var selected: Bool = false {
        didSet {
            if selected != oldValue {
                needsDisplay = true
            }
        }
    }
    var highlightState: NSCollectionViewItemHighlightState = .None {
        didSet {
            if highlightState != oldValue {
                needsDisplay = true
            }
        }
    }

    // MARK: NSView
    override var wantsUpdateLayer: Bool {
        return true
    }

    override func updateLayer() {
        if selected {
            self.layer?.cornerRadius = 10
            layer!.backgroundColor = NSColor.darkGrayColor().CGColor
        } else {
            self.layer?.cornerRadius = 0
            layer!.backgroundColor = NSColor.lightGrayColor().CGColor
        }

    }

    // MARK: init
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.masksToBounds = true
    }
}