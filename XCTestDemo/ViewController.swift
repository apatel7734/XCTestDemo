//
//  ViewController.swift
//  XCTestDemo
//
//  Created by Patel, Ashish on 1/26/16.
//  Copyright © 2016 Patel, Ashish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputURLLabel: UILabel!
    @IBOutlet weak var responseCodeLabel: UILabel!
    @IBOutlet weak var mimeTypeLabel: UILabel!
    var twitterConnection = TwitterConnection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func didTapOnNetworkCall(sender: AnyObject) {
        
        let url = NSURL(string: "https://www.google.com")!
        doSomeNetworkWorWith(url) { (response, mimeType, url, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.inputURLLabel.text = url?.absoluteString
                self.responseCodeLabel.text = "\(response?.statusCode)"
                self.mimeTypeLabel.text = mimeType
            })
        }
    }
    
    
    @IBAction func didTapClearButton(sender: AnyObject) {
        self.inputURLLabel.text = ""
        self.responseCodeLabel.text = ""
        self.mimeTypeLabel.text = ""
    }
    
    func doSomeNetworkWorWith(inputURL: NSURL, handlerBlock: (response: NSHTTPURLResponse?, mimeType: String?, url: NSURL? , error: NSError?) -> Void){
        let request = NSURLRequest(URL: inputURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let httpURLResponse = response as? NSHTTPURLResponse, httpMimeType = httpURLResponse.MIMEType, httpURL = httpURLResponse.URL{
                handlerBlock(response: httpURLResponse, mimeType: httpMimeType, url: httpURL, error: nil)
            }else{
                handlerBlock(response: nil, mimeType: nil, url: nil, error: error)
            }
        }
        task.resume()
    }
    
    func updateTweetView(){
        
    }
}

