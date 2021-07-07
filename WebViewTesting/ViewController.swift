//
//  ViewController.swift
//  WebViewTesting
//
//  Created by Robby Abaya on 6/23/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler {
    public var eventName: String?
    public var eventBody: String?

    override func loadView() {
        super.loadView()
        let script = getScript()
        let wkScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController.addUserScript(wkScript)
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "successEvent")
        view = webView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let webView = view as? WKWebView {
            webView.loadHTMLString(getHTML(), baseURL: nil)
        }
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        eventName = message.name
        eventBody = message.body as? String
        print("\(String(describing: eventName)), \(String(describing: eventBody))")
        
        let textView = UITextView(frame: CGRect(x: 10, y: 200, width: view.bounds.width, height: 25))
        textView.text = "\(String(describing: eventName))"
        textView.accessibilityLabel = "resultText"
        view.addSubview(textView)
    }

    private func getScript() -> String {
        return """
        window.addEventListener('message', event => {
            console.log(JSON.stringify(event));
            if (window.webkit && window.webkit.messageHandlers) {
              if (window.webkit.messageHandlers.successEvent) {
                window.webkit.messageHandlers.successEvent.postMessage(JSON.stringify(event.data));
              }
            }
          });
        """
    }
    
    private func getHTML() -> String {
        return """
        <script>
            function handleSuccess() {
                const inputString = document.getElementById("inputText").value
                const successEvent = {
                  eventType: "success",
                  payload: {
                    value: inputString
                  }
                }
                console.log(JSON.stringify(successEvent))
                window.postMessage(successEvent, "*")
            }
        </script>
        <input id="inputText" type="text" aria-label="Input"></input>
        <button onclick="handleSuccess()" aria-label="Success">Success</button>
        <div id="status" aria-label="status"></div>
        """
    }
}

