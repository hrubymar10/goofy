//
//  TitleLabel.swift
//  GoofySwift
//
//  Created by Daniel Büchele on 11/04/15.
//  Copyright (c) 2015-2017 Daniel Büchele, 2018 Martin Hrubý (hrubymar10). All rights reserved.
//

import Cocoa

class TitleLabel: NSViewController {
    
    var titleLabel : NSTextField?
    var activeLabel : NSTextField?


    // MARK: - NSView Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        
        activeLabel = NSTextField(frame: CGRect(x: 40, y: -18, width: self.view.frame.width, height: 36))
        activeLabel?.stringValue = ""
        activeLabel?.isEditable = false
        activeLabel?.isBezeled = false
        activeLabel?.isSelectable = false
        activeLabel?.drawsBackground = false
        activeLabel?.alignment = .center
        activeLabel?.font = NSFont.systemFont(ofSize: 10.0)
        switch appDelegate.getTheme() {
        case "default":
            activeLabel?.textColor = NSColor.gray
        case "dark":
            activeLabel?.textColor = NSColor.gray
        default:
            activeLabel?.textColor = NSColor.gray
        }
        self.view.addSubview(activeLabel!)
        
        titleLabel = NSTextField(frame: CGRect(x: 40, y: 0, width: self.view.frame.width, height: 36))
        titleLabel?.stringValue = ""
        titleLabel?.isEditable = false
        titleLabel?.isBezeled = false
        titleLabel?.isSelectable = false
        titleLabel?.drawsBackground = false
        titleLabel?.alignment = .center
        titleLabel?.textColor = NSColor.black
        titleLabel?.font = NSFont.systemFont(ofSize: 14.0)
        switch appDelegate.getTheme() {
        case "default":
            titleLabel?.textColor = NSColor.black
        case "dark":
            titleLabel?.textColor = NSColor.white
        default:
            titleLabel?.textColor = NSColor.black
        }
        self.view.addSubview(titleLabel!)
    }

    
    // MARK: - Title
    
    func setTitle(_ title: String, active: String) {
        
        var rect :CGRect? = titleLabel?.frame
        var y :CGFloat = 0.0
        if active=="" {
            y = -6
        }
        rect?.origin.y = y
        titleLabel?.frame = rect!
        titleLabel?.stringValue = title
        activeLabel?.stringValue = active
        
    }


    // MARK: - Window

    func windowDidResize() {
        
        var toolbarItem : NSToolbarItem!
        let appDelegate = NSApplication.shared.delegate as! AppDelegate;
        for item in appDelegate.toolbar.items {
            let i = item 
            if i.view == self.view {
                toolbarItem = i
                break
            }
        }
        
        var rect :CGRect? = titleLabel?.frame
        var width = toolbarItem.view?.frame.width
        width = width!-40
        rect?.size.width = width!
        titleLabel?.frame = rect!
        
        var rect2 = activeLabel?.frame
        rect2?.size.width = width!
        activeLabel?.frame = rect2!
        
    }
    
    
}
