//
//  AppDelegate.swift
//  Link-It
//
//  Created by Kerbal on 3/30/19.
//  Copyright © 2019 bryannip. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item: NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        item?.button?.image = NSImage(named: "link")
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Link It!", action: #selector(AppDelegate.linkIt), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: ""))
        
        item?.menu = menu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func linkIt() {
        print("Pressed")
        
        if let items = NSPasteboard.general.pasteboardItems {
            for item in items {
                for type in item.types {
                    if type.rawValue == "public.utf8-plain-text" {
                        if let url = item.string(forType: type) {
                            NSPasteboard.general.clearContents()
                            
                            var actualURL = ""
                            
                            if(url.hasPrefix("http://") || url.hasPrefix("https://")) {
                                actualURL = url
                            } else {
                                actualURL = "http://\(url)"
                            }
                            
                            NSPasteboard.general.setString("<a href=\"\(actualURL)\">\(url)</a>" , forType: NSPasteboard.PasteboardType(rawValue: "public.html"))
                            
                            NSPasteboard.general.setString(url, forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))
                        }
                    }
                }
            }
        }
    }
    
    func printPasteBoard() {
        if let items = NSPasteboard.general.pasteboardItems {
            for item in items {
                for type in item.types {
                    print("Type: \(type)")
                    print("String: \(String(describing: item.string(forType: type)))")
                }
            }
        }
        
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
}

