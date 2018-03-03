//
//  ThemeSelector.swift
//  GoofySwift
//
//  Created by Martin Hrubý (hrubymar10) on 03/02/18.
//  Copyright (c) 2018 Martin Hrubý (hrubymar10). All rights reserved.
//

import Cocoa

class ThemeSelector: NSPanel {
    @IBOutlet weak var themesTable: NSTableView!
    let tableViewData = [
        ["name":"Default","theme":"default","author":"@hrubymar10","preview":"default"],
        ["name":"Dark","theme":"dark","author":"@hrubymar10","preview":"dark"],
    ]
    var themeIndex = 0
    
    override func awakeFromNib() {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        themesTable.delegate = self
        themesTable.dataSource = self
        themesTable.headerView = nil
        themesTable.allowsEmptySelection = false
        themesTable.allowsMultipleSelection = false
        themeIndex = tableViewData.index(where: {$0["theme"] == appDelegate.getTheme()})!
        themesTable.selectRowIndexes(NSIndexSet(index: themeIndex) as IndexSet, byExtendingSelection: false)
        themesTable.action = #selector(selectTheme)
    }
    
    @objc private func selectTheme() {
        if (themesTable.selectedRow != themeIndex) {
            func dialogOKCancel(question: String, text: String) -> Bool {
                let alert = NSAlert()
                alert.messageText = question
                alert.informativeText = text
                alert.alertStyle = .warning
                alert.addButton(withTitle: "Relaunch")
                alert.addButton(withTitle: "Cancel")
                return alert.runModal() == .alertFirstButtonReturn
            }
            
            let answer = dialogOKCancel(question: "Relaunch now?", text: "Application needs to be relaunched to switch theme.")
            
            if (answer) {
                let appDelegate = NSApplication.shared.delegate as! AppDelegate
                appDelegate.defaults.set(tableViewData[themesTable.selectedRow]["theme"], forKey: "theme")
                appDelegate.defaults.synchronize()
                let url = URL(fileURLWithPath: Bundle.main.resourcePath!)
                let path = url.deletingLastPathComponent().deletingLastPathComponent().absoluteString
                let task = Process()
                task.launchPath = "/usr/bin/open"
                task.arguments = [path]
                task.launch()
                exit(0)
            }
        }
    }
}

extension ThemeSelector: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let result:ThemeSelectorCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultCell"), owner: self) as! ThemeSelectorCell
        result.nameField.stringValue = tableViewData[row]["name"]!
        result.authorField.stringValue = tableViewData[row]["author"]!
        result.previewView.image = NSImage(named: NSImage.Name(rawValue: tableViewData[row]["preview"]!))
        result.backgroundStyle = NSView.BackgroundStyle.dark
        return result;
    }
}

class ThemeSelectorCell: NSTableCellView {
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var authorField: NSTextField!
    @IBOutlet weak var previewView: NSImageView!
}
