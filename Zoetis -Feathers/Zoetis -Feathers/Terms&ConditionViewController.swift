//
//  Terms&ConditionViewController.swift
//  Zoetis -Feathers
//
//  Created by "" on 09/02/17.
//  Copyright © 2017 "". All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import ReachabilitySwift
import SystemConfiguration
import WebKit

class Terms_ConditionViewController: UIViewController, UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate {
 @IBOutlet weak var wkwebView: WKWebView!
    var isLinkedClicked = Bool()
    var isFirstTimeLoad = Bool()
    var accestoken = String()
    var webLoads = Int()
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var acceptOutlet: UIButton!
    @IBAction func clickOnBackButton(_ sender: AnyObject) {
        
        if wkwebView.canGoBack{
            wkwebView.goBack()
        }
        
        

//        if webView.canGoBack {
//            webView.goBack()
//        }
    }
   var lngId = UserDefaults.standard.integer(forKey: "lngId")

    override func viewDidLoad() {
        super.viewDidLoad()
        // self.postTermsCond()
        wkwebView.uiDelegate = self
            wkwebView.navigationDelegate = self
        backBtn.isHidden = true
        webView.delegate = self
        Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString("Logging in...", comment: ""))
        webLoads = 0
        loadHtmlFile()
        acceptOutlet.layer.borderWidth = 1
        acceptOutlet.layer.cornerRadius = 4.0
        acceptOutlet.layer.borderColor = UIColor.clear.cgColor

        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.wkwebView.stopLoading()
        self.wkwebView.removeFromSuperview()
        
//        self.webView.stopLoading()
//        self.webView.removeFromSuperview()
    }

    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(true, forKey: "Terms&Condition")
    }

    func loadHtmlFile() {
        if lngId == 1 {
            if let url = Bundle.main.url(forResource: "terms-of-use", withExtension: "html") {
                           wkwebView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
                       }

//           let url = Bundle.main.url(forResource: "terms-of-use", withExtension: "html")
//           let request = URLRequest(url: url!)
//           webView.loadRequest(request)

        } else if lngId == 3 {
            if let url = Bundle.main.url(forResource: "index(1)", withExtension: "html") {
                wkwebView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
//            let url = Bundle.main.url(forResource: "index(1)", withExtension: "html")
//            let request = URLRequest(url: url!)
//            webView.loadRequest(request)

        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            Helper.dismissGlobalHUD(self.view)

            if self.webLoads != 1 {
                self.webLoads -= 1
            }

            print(self.webLoads)
           // print(wkwebView.request?.mainDocumentURL?.absoluteString)

            // alternative: not case sensitive
    //let navigationAction: WKNavigationAction!
            if lngId == 1{
                
            var navigationAction: WKNavigationAction!
                
                if let url = navigationAction.request.url, !(url.absoluteString.lowercased().range(of: "terms-of-use.html") != nil) { print("exists")
                                   isFirstTimeLoad = true
                               } else {
                                   isFirstTimeLoad = false
                               }

               
    //            if webView.request?.mainDocumentURL?.absoluteString.lowercased().range(of: "terms-of-use.html") != nil{
    //                print("exists")
    //                isFirstTimeLoad = true
    //            } else {
    //                isFirstTimeLoad = false
    //            }
            }
            else if lngId == 3{
                var navigationAction: WKNavigationAction!
              if let url = navigationAction.request.url, !(url.absoluteString.lowercased().range(of: "index(1).html") != nil) { print("exists")
                    isFirstTimeLoad = true
                } else {
                    isFirstTimeLoad = false
                }
    //            if wkwebView.request.mainDocumentURL.absoluteString.lowercased().range(of: "index(1).html") != nil {
    //                print("exists")
    //                isFirstTimeLoad = true
    //            } else {
    //                isFirstTimeLoad = false
    //            }
            }

            if wkwebView.isLoading {


            } else {

                if isLinkedClicked == true && isFirstTimeLoad == false {
                    backBtn.isHidden = false
                } else {
                    backBtn.isHidden = true
                }
            }
            
            }

//    func webViewDidFinishLoad(_ webView: UIWebView) {
//
//        Helper.dismissGlobalHUD(self.view)
//
//        if self.webLoads != 1 {
//            self.webLoads -= 1
//        }
//
//        print(self.webLoads)
//        print(webView.request?.mainDocumentURL?.absoluteString)
//
//        // alternative: not case sensitive
//
//        if lngId == 1 {
//            if webView.request?.mainDocumentURL?.absoluteString.lowercased().range(of: "terms-of-use.html") != nil {
//                print("exists")
//                isFirstTimeLoad = true
//            } else {
//                isFirstTimeLoad = false
//            }
//        } else if lngId == 3 {
//            if webView.request?.mainDocumentURL?.absoluteString.lowercased().range(of: "index(1).html") != nil {
//                print("exists")
//                isFirstTimeLoad = true
//            } else {
//                isFirstTimeLoad = false
//            }
//        }
//
////        if webView.request?.mainDocumentURL?.absoluteString.lowercased().range(of: "terms-of-use.html") != nil {
////            print("exists")
////            isFirstTimeLoad = true
////        } else {
////            isFirstTimeLoad = false
////        }
//        if webView.isLoading {
//
//        } else {
//
//            if isLinkedClicked == true && isFirstTimeLoad == false {
//                backBtn.isHidden = false
//            } else {
//                backBtn.isHidden = true
//            }
//        }
//    }

    @IBAction func acceptBtn(_ sender: AnyObject) {
    UserDefaults.standard.set(false, forKey: "Terms&Condition")
    UserDefaults.standard.set(false, forKey: "Terms")
      self.postTermsCond()

        UserDefaults.standard.set(true, forKey: "login")

        let birdTypeId = UserDefaults.standard.integer(forKey: "birdTypeId")

        if birdTypeId == 2 {
             UserDefaults.standard.set(false, forKey: "TermsTurkey")
              UserDefaults.standard.set(true, forKey: "TurkeyBird")
             UserDefaults.standard.set(5, forKey: "chick")
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "HelpScreenVcTurkey") as? HelpScreenVcTurkey
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)

        } else if birdTypeId == 1 {
             UserDefaults.standard.set(false, forKey: "TermsChicken")
             UserDefaults.standard.set(true, forKey: "ChickenBird")
             UserDefaults.standard.set(4, forKey: "chick")
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "helpView") as? HelpViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)

        } else if birdTypeId == 3 {

            let mapViewControllerObj = storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC") as? BirdsSelectionVC
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)

        }

    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
      
     
      switch navigationAction.navigationType {

             case .formSubmitted :
                 return
             case .backForward :
                 return
             case .reload :
                 return
             case .formResubmitted :
                 return
             case .other :
                 return

      case .linkActivated:
                 // Open links in Safari
                 isLinkedClicked = true

                 return
             default:
                 // Handle other navigation types...
                 return
             }
          
      }

//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
//        switch navigationType {
//
//        case .formSubmitted :
//            return true
//        case .backForward :
//            return true
//        case .reload :
//            return true
//        case .formResubmitted :
//            return true
//        case .other :
//            return true
//
//        case .linkClicked:
//            // Open links in Safari
//            isLinkedClicked = true
//
//            return true
//        default:
//            // Handle other navigation types...
//            return true
//        }
//    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            self.webLoads -= 1;
       }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         self.webLoads -= 1;
         }
//    func webViewDidStartLoad(_ aWebView: UIWebView) {
//        self.webLoads += 1
//    }
//
//    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        self.webLoads -= 1
//    }

    func postTermsCond() {

        if WebClass.sharedInstance.connected() {

             let Id = UserDefaults.standard.integer(forKey: "Id")

            let Url = "User/PostTermsAccepted"
            let parameters  = ["userId": Id, "TermsAccepted": "true"] as [String: Any]
            print(parameters)
            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!

            let headerDict = ["Authorization": accestoken]
            let urlString: String = WebClass.sharedInstance.webUrl + Url

            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)

            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

            jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)

            print(jsonString)
            Alamofire.request(urlString, method: .post, parameters: parameters, headers: headerDict).responseJSON { response in

                if let JSON = response.result.value {
                    print(JSON)

                    //("JSON: \(JSON)")
                }
            }
        }
    }

}
