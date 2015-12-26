//
//  ViewController.swift
//  BulletinBoard
//
//  Created by CHA-MBP on 2015/12/26.
//  Copyright © 2015年 bulletin board. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var messageBoard: NSStackView!

    @IBOutlet weak var addMessage: NSButton!
    @IBAction func addMessageToStack(sender: NSButton) {
        print("TODO: add function...")
        addStringAsMessage("test...")
        print("add view done...")
    }

    private func addStringAsMessage(str: String) {
        let v: NSTextField = NSTextField(frame: NSRect(x: 200, y: 200, width: 200, height: 200))
        v.stringValue = str
        v.hidden = false
        messageBoard.hidden = false
        messageBoard.addView(v, inGravity: NSStackViewGravity.Center)

        // TODO: use DB module to add new message.
    }

    @IBOutlet weak var removeAllMessages: NSButton!
    @IBAction func removeAllMessageFromStack(sender: NSButton) {
        for subview in messageBoard.subviews {
            messageBoard.removeView(subview)
        }

        // TODO: use DB module to remove messages.
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        let stringMessages = AdaptedDbManager.get()
        for msg in stringMessages {
            addStringAsMessage(msg)
        }
    }
}

class MyView: NSView {

}