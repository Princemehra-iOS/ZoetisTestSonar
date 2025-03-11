//
//  BaseViewController.swift
//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 24/10/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class BaseViewController: UIViewController , SlideMenuDelegate{

    let dropDown = DropDown()
    typealias CompletionHandler = (_ selectedVal:String) -> Void
    typealias CompletionHandlerWithIndex = (_ selectedVal:String, _ index:Int) -> Void
    
    
    func postRequest() -> [String: String] {
        // do a post request and return post data
        return ["someData": "someData"]
    }

    func showAlertMessage(_ vc: UIViewController, titleStr: String, messageStr: String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)

    }

//     func showGlobalProgressHUDWithTitle(_ vc: UIView, title: String) {
//
//        let hud = MBProgressHUD.showAdded(to: vc, animated: true)
//        hud.contentColor = UIColor.white
//       // hud.backgroundView.alpha = 0.9
//        hud.backgroundView.color = UIColor.black.withAlphaComponent(0.4)
//
//        hud.bezelView.color = UIColor(red: 0, green: 0/255, blue: 0, alpha: 1)
//        hud.label.text = title
//        hud.label.font = UIFont(name: "HelveticaNeue", size: 15.0)!
//    }
//
//     func showGlobalProgressHUDWithTitleWithoutHudBack(_ vc: UIView, title: String) {
//
//        let hud = MBProgressHUD.showAdded(to: vc, animated: true)
//        hud.contentColor = UIColor.white
//        // hud.backgroundView.alpha = 0.9
//
//        hud.bezelView.color = UIColor(red: 0, green: 0/255, blue: 0, alpha: 1)
//        hud.label.text = title
//        hud.label.font = UIFont(name: "HelveticaNeue", size: 15.0)!
//      
//    }
//
//    override func dismissGlobalHUD(_ vc: UIView) {
//
//        MBProgressHUD.hide(for: vc, animated: true)
//    }
    
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //slide
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
         let topViewController : UIViewController = self.navigationController!.topViewController!
         print("View Controller is : \(topViewController) \n", terminator: "")
         switch(index){
         case 0:
             print("Home\n", terminator: "")

             self.navigationController?.popViewController(animated: true)
            // self.openViewControllerBasedOnIdentifier("PEDashboardViewController")
             
             break
         case 1:
             print("Play\n", terminator: "")
             
           //  self.openViewControllerBasedOnIdentifier("PEDashboardViewController")
             
             break
         default:
             print("default\n", terminator: "")
         }
     }
     
     func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
       
         /* Story board will change if we use in different module */
         let destViewController  = UIStoryboard.init(name: Constants.Storyboard.peStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: strIdentifier)
     
         let topViewController : UIViewController = self.navigationController!.topViewController!
         
         if (topViewController == destViewController){
             print("Same VC")
         } else {
             self.navigationController!.pushViewController(destViewController, animated: true)
         }
     }
     
     func addSlideMenuButton(){
         let btnShowMenu = UIButton(type: UIButton.ButtonType.system)
         btnShowMenu.setImage(self.defaultMenuImage(), for: UIControl.State())
         btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
         btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
         let customBarItem = UIBarButtonItem(customView: btnShowMenu)
         self.navigationItem.leftBarButtonItem = customBarItem;
     }

     func defaultMenuImage() -> UIImage {
         var defaultMenuImage = UIImage()
         
         UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
         
         UIColor.black.setFill()
         UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
         UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
         UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
         
         UIColor.white.setFill()
         UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
         UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
         UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
         
         defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
         
         UIGraphicsEndImageContext()
        
         return defaultMenuImage;
     }
     
     @objc func onSlideMenuButtonPressed(_ sender : UIButton){
         if (sender.tag == 10)
         {
             // To Hide Menu If it already there
             self.slideMenuItemSelectedAtIndex(-1);
             
             sender.tag = 0;
             
             let viewMenuBack : UIView = view.subviews.last!
             
             UIView.animate(withDuration: 0.3, animations: { () -> Void in
                 var frameMenu : CGRect = viewMenuBack.frame
                 frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                 viewMenuBack.frame = frameMenu
                 viewMenuBack.layoutIfNeeded()
                 viewMenuBack.backgroundColor = UIColor.clear
                 }, completion: { (finished) -> Void in
                     viewMenuBack.removeFromSuperview()
             })
             
             return
         }
         
         sender.isEnabled = false
         sender.tag = 10
         
         let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
         let menuVC : MenuViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
         menuVC.btnMenu = sender
         menuVC.delegate = self
         self.view.addSubview(menuVC.view)
         self.addChild(menuVC)
         menuVC.view.layoutIfNeeded()
         
         
         menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 60, width: 158, height: UIScreen.main.bounds.size.height);
         
         UIView.animate(withDuration: 0.3, animations: { () -> Void in
             menuVC.view.frame=CGRect(x: 0, y: 60, width: 158, height: UIScreen.main.bounds.size.height);
             sender.isEnabled = true
             }, completion:nil)
     }
    
    
    //MARKS: DROP DOWN VIEW
    func dropDownforDistrict(arrayData:[String], kWidth:CGFloat,kAnchor:UIView,yheight:CGFloat,completionHandler:@escaping CompletionHandler){
        var updateArray = [Any]();
        for obj in arrayData {
            var district = obj;
            district = (district.contains("(BO)")) ? district.replacingOccurrences(of: "(BO)", with: "") : district.replacingOccurrences(of: "(MOA)", with: "")
            updateArray.append(district)
        }
        dropDown.dataSource = updateArray as [AnyObject];
        dropDown.width = kWidth
        dropDown.anchorView = kAnchor
        dropDown.bottomOffset = CGPoint(x: 0, y:yheight+20)
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            self.dropDown.deselectRowAtIndexPath(index)
            completionHandler(item);
        }
    }
    
    func getDropListSelectedIDDistrict(dropSelected:String,fullObjArry:[Any],key:String)->Int{
        var index:Int = -1;
        
        var updateArray = [Any]()
        for objs in fullObjArry {
            let dictObj = objs as? [String:Any] ?? [String:Any]();
            var districts = dictObj["districtName"] as? String ?? ""
            districts = (((districts) as AnyObject).contains("(BO)")) ? districts.replacingOccurrences(of: "(BO)", with: "") : districts.replacingOccurrences(of: "(MOA)", with: "")
            updateArray.append(districts);
            
        }
        for obj in updateArray {
            index = index + 1;
            let val = obj as? String ?? "";
            if val == dropSelected {
                break;
            }
        }
        return index;
    }
    
    //MARKS: DROP DOWN VIEW
    func dropDownVIew(arrayData:[String], kWidth:CGFloat,kAnchor:UIView,yheight:CGFloat,completionHandler:@escaping CompletionHandler){
        dropDown.dataSource = arrayData as [AnyObject];
        dropDown.width = kWidth
        dropDown.anchorView = kAnchor
        dropDown.bottomOffset = CGPoint(x: 0, y:yheight+20)
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            self.dropDown.deselectRowAtIndexPath(index)
            completionHandler(item);
        }
    }
    
    func dropDownVIewNew(arrayData:[String], kWidth:CGFloat,kAnchor:UIView,yheight:CGFloat,completionHandler:@escaping CompletionHandlerWithIndex){
        dropDown.dataSource = arrayData as [AnyObject];
        dropDown.width = kWidth
        dropDown.anchorView = kAnchor
        dropDown.bottomOffset = CGPoint(x: 0, y:yheight+20)
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            self.dropDown.deselectRowAtIndexPath(index)
            completionHandler(item, index);
        }
    }
    
    //Marks:  GET DROP LIST ARRAY
    func getDropArrayList(array:Array<Any>,key:String)->[String]{
        var dropArray = Array<String>();
        for obj in array {
            let dictObj = obj as? Dictionary<String,Any> ?? Dictionary<String,Any>();
            dropArray.append(dictObj[key] as? String ?? "");
        }
        return dropArray;
    }
    
    //MARKS: GET DROW DOWN OBJECT INDEX
    func getDropListSelectedID(dropSelected:String,fullObjArry:[Any],key:String)->Int{
        var index:Int = -1;
        for obj in fullObjArry {
            index = index + 1;
            let dictObj = obj as? Dictionary<String,Any> ?? Dictionary<String,Any>();
            let val = dictObj[key] as? String ?? "";
            if val == dropSelected {
                break;
            }
        }
        return index;
    }
    
    //Marks:  GET DROP LIST ARRAY
    func getIntDropArrayList(array:Array<Any>,key:String)->[Int]{
        var dropArray = Array<Int>();
        for obj in array {
            let dictObj = obj as? Dictionary<String,Any> ?? Dictionary<String,Any>();
            dropArray.append(dictObj[key] as? Int ?? 0);
        }
        return dropArray;
    }
    
    //MARKS: GET DROW DOWN OBJECT INDEX
    func getIntDropListSelectedID(dropSelected:Int,fullObjArry:[Any],key:String)->Int{
        var index:Int = -1;
        for obj in fullObjArry {
            index = index + 1;
            let dictObj = obj as? Dictionary<String,Any> ?? Dictionary<String,Any>();
            let val = dictObj[key] as? Int ?? 0;
            if val == dropSelected {
                break;
            }
        }
        return index;
    }
    
    func shadowButton(btn:UIButton){
        btn.layer.cornerRadius = 6.0
        btn.layer.masksToBounds = false
      //  btn.layer.shadowColor = UIColor.getUIColorWithRGB(126, g: 20, b: 0).cgColor;
        btn.layer.shadowOffset = CGSize(width: 0,height: 5.0)
        btn.layer.shadowRadius = 0.0
        btn.layer.shadowOpacity = 1.0
        btn.layer.shouldRasterize = true
    }

    
    
    
}
