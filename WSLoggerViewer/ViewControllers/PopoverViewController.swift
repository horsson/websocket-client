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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        aceView.setString("{ \"name\":\"John\", \"age\":30, \"car\":null }")
        aceView.setMode(.JSON)
        aceView.setTheme(.xcode)
        
    }
    
}

extension PopoverViewController : ACEViewDelegate {
    
}
