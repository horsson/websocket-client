//
//  WebViewController.swift
//  WSLoggerViewer
//
//  Created by Hu, Hao on 14.06.18.
//  Copyright © 2018 Hao. All rights reserved.
//

import Cocoa

class WebViewController: NSViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let url = URL(string: "https://copilotrcw0012d20a-wfd7746b4.int.sap.hana.ondemand.com/copilot/ui/runsimple/index.htm")!
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
}
