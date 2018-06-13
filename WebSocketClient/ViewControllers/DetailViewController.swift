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
    
    
    @IBOutlet weak var endPointText: NSTextField!
    @IBOutlet weak var statusImage: NSImageView!
    
    @IBOutlet weak var connectButton: NSButton!

    
    @IBOutlet var logText: NSTextView!
    
    private var webSocket: WebSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
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
        let textStoreage = logText.textStorage;
        
        let str = debugString(forText: text)
        textStoreage?.append(str)
        textStoreage?.append(NSAttributedString(string: "\n"))
        
    }
    func websocketDidReceiveData(socket: WebSocketClient, data: Data){
        
    }
}
