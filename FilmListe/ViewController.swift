//
//  ViewController.swift
//  FilmListe
//
//  Created by Ruedi Heimlicher on 16.01.2024.
//

import Cocoa
import Foundation




class rViewController: NSViewController ,NSTableViewDelegate,NSTableViewDataSource
{

   var pfad = ""
   @IBOutlet weak var Filmordner: NSTextField!
   
   @IBOutlet weak var Filmtable: NSTableView!

   var FilmArray = [[String:String]]()
   
   override func viewDidLoad() {
      super.viewDidLoad()
   // https://developer.apple.com/forums/thread/654874      Filmtable.usesAutomaticRowHeights = true
      // Do any additional setup after loading the view.
   }

   override var representedObject: Any? {
      didSet {
      // Update the view, if already loaded.
      }
   }

   @IBAction  func report_Open(_ sender: NSButton) // 
   {
      print("Pfad: *\(pfad)*")
      let openPanel = NSOpenPanel()
      openPanel.canChooseFiles = false
      openPanel.allowsMultipleSelection = false
      openPanel.canChooseDirectories = true
      openPanel.canCreateDirectories = false
      openPanel.title = "Select a folder"
      
      openPanel.beginSheetModal(for:self.view.window!) { (response) in
         if response.rawValue == NSApplication.ModalResponse.OK.rawValue 
         {
            let selectedPath = openPanel.url!.path
            // do whatever you what with the file path
            Swift.print("path: \(selectedPath)")
            self.pfad = selectedPath
            self.Filmordner.stringValue = selectedPath
         }
         openPanel.close()
         self.readList()
      }
      
   }

   
   func readList()
   {
      // von TV_Titel
      print("Pfad: *\(pfad)*")
      let fileManager = FileManager.default
      
      // https://www.hackingwithswift.com/example-code/system/how-to-read-the-contents-of-a-directory-using-filemanager
      do 
      {
         let items = try fileManager.contentsOfDirectory(atPath: pfad)
         
         for item in items 
         {
            //print("\t \(item)")
         }
         
         for item in items 
         {
            // 2020-05-30_13_45_ZDF_Inga-Lindstroem-Sommer-der-Erinnerung-00.03.11.879-01.30.41.619.mp4
            //print("Found \(item)")
            //print("item: \(item)")
            var titelarray =  item.components(separatedBy: " ")
            let datum = titelarray[0]
            
            titelarray.removeFirst()
            var titelstring = titelarray.joined(separator: " ")
           // print("Datum: \(datum) titelstring: \(titelstring)")
            
            var titelpfad = pfad+"/"+item
            var titelurl = URL.init(string: titelpfad)
            //print ("titelpfad: \(titelpfad) url: \(titelurl)")
            
         } // for items
         
         
      }// do
      catch 
      {
         print("failed to read directory")
         
         
      }
      
      let pfadurl = NSURL(fileURLWithPath: self.pfad)
      
      do {
         let fileURLs = try fileManager.contentsOfDirectory(at: pfadurl as URL, includingPropertiesForKeys: nil)
         //print("fileURLs: \(fileURLs)")
         for filmzeile in fileURLs
         {
            var filmzeilendic  = [String:String]()
            filmzeilendic["pfad"] = filmzeile.path
            var zeilenarray =  filmzeile.path.components(separatedBy: "/")
            let anz = zeilenarray.count
            let datumstring = zeilenarray.first
            let genrestring = zeilenarray[anz-2]
            let volumestring = zeilenarray[anz-3]
            let titelstring = zeilenarray.last
            filmzeilendic["titel"] = zeilenarray.last
            print("filmzeile: \(filmzeile.path) volumestring: \(volumestring) genrestring: \(genrestring) titelstring: \(titelstring)")
            print("filmzeilendic: \(filmzeilendic)")
            FilmArray.append(filmzeilendic)
            
         }// for urls
         print("FilmArray: \(FilmArray)")
         Filmtable.reloadData()
         // process files
      } catch {
         print("Error while enumerating files \(pfadurl.path): \(error.localizedDescription)")
         
      }

   }// readList
   
   

}// ViewController

//MARK: dataTable
extension rViewController
{
   func numberOfRows(in tableView: NSTableView) -> Int 
   {
      
      return (FilmArray.count)
      
   }
   
   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
      let zeile = FilmArray[row]
      print("ident: \(tableColumn!.identifier.rawValue)")
      let ident = tableColumn!.identifier.rawValue
      if ident == "titel"
      {
         //print("Filmzeile: \(zeile)")
         let cell = tableView.makeView(withIdentifier: (tableColumn!.identifier), owner: self) as? NSTableCellView
         
         cell?.textField?.stringValue = (zeile[tableColumn!.identifier.rawValue]!)
         return cell
      }
      else if ident == "pfad"
      {
         let cell = tableView.makeView(withIdentifier: (tableColumn!.identifier), owner: self) as? NSTableCellView
         
         cell?.textField?.stringValue = (zeile[tableColumn!.identifier.rawValue]!)
         return cell

      }
      else
      {
         let cell = tableView.makeView(withIdentifier: (tableColumn!.identifier), owner: self) as? NSTableCellView
         return cell
         
      }
      
      
   }
}
