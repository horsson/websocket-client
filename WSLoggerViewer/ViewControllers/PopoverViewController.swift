//
//  PopoverViewController.swift
//  WebSocketClient
//
//  Created by Hu, Hao on 13.06.18.
//  Copyright © 2018 Hao. All rights reserved.
//

import Cocoa



class PopoverViewController: NSViewController {
    @IBOutlet weak var aceView: ACEView!
    
    public var codeText:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if let text = self.codeText {
            let beautifulString = formatJson(string: text)
            if beautifulString != nil {
                aceView.setString(beautifulString)
            } else {
                aceView.setString(text)
            }
            
        }
        
        aceView.setMode(.JSON)
        aceView.setTheme(.xcode)
    }
    
    @IBAction func copyDidClick(_ sender: Any) {
        let stringToCopy = aceView.string()!
        
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        
        pasteBoard.writeObjects([stringToCopy as NSPasteboardWriting])
        
    }
    
    private func formatJson(string: String) -> String? {
        let jsonData = string.data(using: .utf8)!;
        guard let jsonRoot = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
            return nil
        }
        
        
        let beatufyData = try! JSONSerialization.data(withJSONObject: jsonRoot, options: [.prettyPrinted]);
        return String(data: beatufyData, encoding: .utf8);
    }
    
}

extension PopoverViewController : ACEViewDelegate {
    
}
