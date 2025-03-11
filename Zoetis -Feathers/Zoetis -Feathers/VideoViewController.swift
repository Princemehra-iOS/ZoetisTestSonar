//
//  VideoViewController.swift
//  Zoetis -Feathers
//
//  Created by    on 5/29/17.
//  Copyright © 2017   . All rights reserved.
//

import UIKit
import AVFoundation
import MBProgressHUD
import WebKit

class VideoViewController: UIViewController, UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate {
     @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var webView: UIWebView!
    var hud1: MBProgressHUD = MBProgressHUD()
    @IBOutlet weak var subHeader: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        wkWebView.scrollView.isScrollEnabled = false
               wkWebView.scrollView.bounces = false
               wkWebView.uiDelegate = self
               wkWebView.navigationDelegate = self
//        webView.scrollView.isScrollEnabled = false
//        webView.scrollView.bounces = false
//        webView.delegate=self
      self.subHeader.text = NSLocalizedString("Tutorial Videos", comment: "")
        loadLoader()
        self.perform(#selector(VideoViewController.loadHtmlFile), with: nil, afterDelay: 0.5)
    }
    func loadLoader() {

        hud1 = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud1.contentColor = UIColor.white
        hud1.bezelView.color = UIColor.black
        hud1.label.text = "Loading..."
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    @objc func loadHtmlFile() {

        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        let pathToReportHTMLTemplate: String?
        if lngId == 3 {
            let val = UserDefaults.standard.integer(forKey: "chick")
            if val  ==  4 {
                pathToReportHTMLTemplate = Bundle.main.path(forResource: "video-details_4", ofType: "html")
                } else {
                pathToReportHTMLTemplate = Bundle.main.path(forResource: "video-details", ofType: "html")
            }
            } else {
         pathToReportHTMLTemplate = Bundle.main.path(forResource: "video-details", ofType: "html")
        }
        let HTMLContent = try? String(contentsOfFile: pathToReportHTMLTemplate!, encoding: String.Encoding.utf8)
        wkWebView.loadHTMLString(HTMLContent!, baseURL: Bundle.main.bundleURL)
    }
    
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//
//       hud1.hide(animated: true)
//    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
             hud1.hide(animated: true)
       }
    @IBAction func btnPressed(_ sender: AnyObject) {
        let url = URL(string: "https://www.youtube.com/watch?v=QJvmvOPcc8w")!
        UIApplication.shared.openURL(url)
    }
    @IBAction func url2Pressed(_ sender: AnyObject) {
        let url = URL(string: "https://youtu.be/f_cD6GB7k0U")!
        UIApplication.shared.openURL(url)
    }
    @IBAction func url3Pressed(_ sender: AnyObject) {
        let url = URL(string: "https://youtu.be/R0Qnv3qlWA4")!
        UIApplication.shared.openURL(url)
    }

}
