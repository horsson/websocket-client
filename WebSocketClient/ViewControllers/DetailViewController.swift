//
//  DetailViewController.swift
//  WebSocketClient
//
//  Created by Hu, Hao on 11.06.18.
//  Copyright © 2018 Hao. All rights reserved.
//

import Cocoa
import Starscream


class DetailViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var endPointText: NSTextField!
    @IBOutlet weak var statusImage: NSImageView!
    
    @IBOutlet weak var connectButton: NSButton!

    
    private var webSocket: WebSocket!
    
    
    private var logEntries = [LogEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do view setup here.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let url = endPointText.stringValue
        webSocket = WebSocket(url: URL(string: url)!)
        webSocket.delegate = self
    }
    @IBAction func sendDidClick(_ sender: Any) {
        webSocket.write(string: "test")
    }
    
    @IBAction func connectDidClick(_ sender: Any) {
        
        if webSocket.isConnected{
            webSocket.disconnect()
        } else{
            webSocket.connect()
        }
        
    }
    
    @IBAction func resizeFont(_ sender: Any) {
        
        let button = sender as! NSButton
        
        guard let image = button.image else {
            return
        }
        
        if image.name()?.rawValue == "NSAddTemplate" {
            
        } else {
            
        }
        
        
    }
    
    private func increaseSize(){
        
    }
    
    
    private func decreaseSize(){
        
    }
    
    
    private func debugString(forText text: String) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string:text)
        let attributes0: [NSAttributedStringKey : Any] = [
            .font: NSFont(name: "HelveticaNeue", size: 12)!
        ]
        
        attributedString.addAttributes(attributes0, range: NSRange(location: 0, length: text.lengthOfBytes(using: .utf8)))
        return attributedString

    }
    
    
    
}


//MARK: NSTableView

extension DetailViewController: NSTableViewDataSource, NSTableViewDelegate{
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return logEntries.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let entry = logEntries[row]
        
        var cellIdentifier = ""
        var text = ""
        
        if tableColumn == tableView.tableColumns[0] {
            //Log level
            cellIdentifier = "LogLevel";
            text = entry.logLevel.representation
            
        } else {
            //Log content
            cellIdentifier = "LogContent";
            text = entry.logContent
        }
        
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            
            if cellIdentifier == "LogLevel" {
                cell.wantsLayer = true
                cell.layer?.backgroundColor = entry.logLevel.color.cgColor
            }
            
            return cell
        }
        
        return nil
    }
    
    
    
}


//MARK: WebSocket

extension DetailViewController : WebSocketDelegate{
    
    func websocketDidConnect(socket: WebSocketClient){
        print("Socket did connect.")
        connectButton.title = "Disconnect"
        statusImage.image = NSImage(named: NSImage.Name("green_circle"))
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?){
        connectButton.title = "Connect"
        statusImage.image = NSImage(named: NSImage.Name("red_circle"))
        
    }
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String){
        
        let logEntry = LogEntry(logString: text)
        logEntries.append(logEntry)
        tableView.reloadData()
        
    }
    func websocketDidReceiveData(socket: WebSocketClient, data: Data){
        
    }
}
