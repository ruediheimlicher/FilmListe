//
//  rPlayerfensterController.swift
//  FilmListe
//
//  Created by Ruedi Heimlicher on 18.01.2024.
//


import Cocoa
import Foundation
import AVKit
import AVFoundation
import SwiftUI

class rFilmController: NSWindowController 
{
   // https://forums.developer.apple.com/forums/thread/704420

   @IBOutlet weak var titelfeld: NSTextField!  // That is the unique item in the window ; you will have more
    
   @IBOutlet  weak var Filmfeld: AVPlayer!
   
   
   var Filmplayer:rPlayerController!
   
     //  set nib name for the window identical to file name
     override var windowNibName: NSNib.Name! 
   { // StatusWindow.xib is the file nam for the xib
         return NSNib.Name("Filmfenster")
     }
     
     override init(window: NSWindow!) {
         super.init(window: window)
     }
     
     required init?(coder: (NSCoder?)) { // I had a warning here  Using '!' in this location is deprecated and will be removed in a future release; consider changing this to '?' instead - For NSCoder!
         super.init(coder: coder!)   // should check in case coder is nil ?
     }
   
   override func windowDidLoad() 
   {
     super.windowDidLoad()
     //1.
     if let window = window, let screen = window.screen {
       let offsetFromLeftOfScreen: CGFloat = 100
       let offsetFromTopOfScreen: CGFloat = 100
       //2.
       let screenRect = screen.visibleFrame
       //3.
       let newOriginY = screenRect.maxY - window.frame.height - offsetFromTopOfScreen
       //4.
       window.setFrameOrigin(NSPoint(x: offsetFromLeftOfScreen, y: newOriginY))
     }
   }

   
   
   @objc func setFilmURL(url:URL)
   {
      
   }

 
      
   }

