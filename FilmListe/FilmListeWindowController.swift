//
//  FilmListeWindowController.swift
//  FilmListe
//
//  Created by MacMini21 on 28.01.24.
//

import Foundation
import Cocoa

class FilmListeWindowController: NSWindowController, NSWindowDelegate {
    
    let minWindowWidth: CGFloat = 200
    let minWindowHeight: CGFloat = 150
    let maxWindowWidth: CGFloat = 1200
    let maxWindowHeight: CGFloat = 900

    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.minSize = CGSize(width: minWindowWidth,
                                 height: minWindowHeight)
        window?.maxSize = CGSize(width: maxWindowWidth,
                                 height: maxWindowHeight)

        window?.makeKeyAndOrderFront(nil)
        window?.center()
    }


    func windowWillClose(_ notification: Notification) 
    {
        print("windowWillClose")
        //let nc = NotificationCenter.default
        //nc.post(name:Notification.Name(rawValue:"beenden"),
        //        object: nil,
         //       userInfo: nil)

        NSApplication.shared.terminate(self)
    }
}
