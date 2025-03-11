//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 08/11/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {

    func noInternetConnection() {
        //        alert.sharedInstance.showAlertView(title:"Alert", message:"No Internet Connection Found", actionTitles: JacksonArt.ButtonTitle.setting, JacksonArt.ButtonTitle.cancel], actions: [
        //            {()->() in
        //                guard let urlString = URL(string: UIApplication.openSettingsURLString) else {return}
        //                UIApplication.shared.open(urlString, options: [:], completionHandler: nil)
        //            },
        //            {()->() in
        //            }
        //        ])
        showAlertViewWithMessageAndActionHandler(message: "No internet connection found") {
            guard let urlString = URL(string: UIApplication.openSettingsURLString) else {return}
            UIApplication.shared.open(urlString, options: [:], completionHandler: nil)
        }
    }
    
    // MARK:- Show AlertView function
    internal func showAlert(title:String, message:String,owner:UIViewController) {
        
        let alertView = UIAlertView(title: title as String, message: message as String, delegate:self, cancelButtonTitle: "OK")
        alertView.alertViewStyle = .default
        alertView.show()
    }
    
}

extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
