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
    
    @IBOutlet weak var connectButton: NSButton!
    @IBOutlet var messageText: NSTextView!
    
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
        let message = messageText.string
        webSocket.write(string: message)
    }
    
    @IBAction func connectDidClick(_ sender: Any) {
        
        
        if webSocket.isConnected{
            webSocket.disconnect()
        } else{
            webSocket.connect()
        }
        
    }
//    private func attributedString(forText: String) : NSAttributedString {
//                
//    }
    
}


extension DetailViewController : WebSocketDelegate{
    func websocketDidConnect(socket: WebSocketClient){
        print("Socket did connect.")
        connectButton.title = "Disconnect"
        
    }
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?){
        connectButton.title = "Connect"
        
    }
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String){
        let textStoreage = logText.textStorage;
        
        textStoreage?.append(NSAttributedString(string: text))
        textStoreage?.append(NSAttributedString(string: "\n"))
        
    }
    func websocketDidReceiveData(socket: WebSocketClient, data: Data){
        
    }
}
