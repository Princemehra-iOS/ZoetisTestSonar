//
//  PE_FinalizeCell.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 19/02/20.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class PE_SessionCell: UITableViewCell {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var lblAssessment: UILabel!
    @IBOutlet weak var lblEvaluationDate: UILabel!
    @IBOutlet weak var lblEvaluationType: UILabel!
    @IBOutlet weak var lblEvaluator: UILabel!
    @IBOutlet weak var lblSiteName: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var idInfoImg: UIImageView!
    @IBOutlet weak var extendedMicroLbl: UILabel!
    
    @IBOutlet weak var emstatus: UILabel!
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var emRejectedComentBtn: UIButton!
    
    // MARK: - VARIABLES

    var tipView: ToolTipView?
    let blackTranparentView = UIView()
    var tipPosition : ToolTipPosition = .middle
    var tapGestureOnLabel1 : ((UITapGestureRecognizer) -> ())?
    var editCompletion:((_ string: String?) -> Void)?
    var deleteCompletion:((_ string: String?) -> Void)?
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: - METHODS

    override func awakeFromNib() {
        super.awakeFromNib()
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(PE_SessionCell.tapFunctionForInfo))
        self.idInfoImg.isUserInteractionEnabled = true
        self.idInfoImg.addGestureRecognizer(tap1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @objc func tapFunctionForInfo(sender: UITapGestureRecognizer) {
        self.tapGestureOnLabel1?(sender)
    }
    
    func showToolTipTest(cell: PE_SessionCell, sender: UIView, refRange: String, tapGuesture: UITapGestureRecognizer) {
        
        self.tipView?.removeFromSuperview()
        self.blackTranparentView.removeFromSuperview()
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        blackTranparentView.frame = viewController?.view.frame ?? CGRect.zero
        blackTranparentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        viewController?.view.addSubview(blackTranparentView)
        
        let tipWidth: CGFloat = 220
        let tipHeight: CGFloat = 80
        let point = tapGuesture.location(in: viewController?.view)
        var tipX = point.x - tipWidth / 2 - 10
        var tipY: CGFloat = point.y - 90
        
        if self.tipPosition == .right {
            tipX = point.x - tipWidth - 27
            tipY = point.y - tipHeight / 2  + 6
        }
        tipView = ToolTipView(frame: CGRect(x: tipX, y: tipY, width: tipWidth, height: tipHeight), text: refRange, tipPos: self.tipPosition)
        
        viewController?.view.addSubview(tipView ?? UIView())
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(blackTransparentViewTapped(sender:)))
        blackTranparentView.isUserInteractionEnabled = true
        blackTranparentView.addGestureRecognizer(tap1)
        performShow(tipView)
    }
    func performShow(_ v: UIView?) {
        v?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseOut, animations: {
            v?.transform = .identity
        }) { finished in
            // do something once the animation finishes, put it here
        }
    }
    @objc func blackTransparentViewTapped(sender:UITapGestureRecognizer) {
        self.blackTranparentView.removeFromSuperview()
        self.tipView?.removeFromSuperview()
    }
    
    
    
    func config(peNewAssessment:PENewAssessment, index: IndexPath)  {
        self.tapGestureOnLabel1 = { (sender) in
            let assId = "C-" + "\(peNewAssessment.dataToSubmitID ?? "")"
            self.showToolTipTest(cell: self, sender: self.parentViewController?.view ?? UIView(), refRange: assId, tapGuesture: sender)
        }
        lblEvaluationDate.text = peNewAssessment.evaluationDate
        lblEvaluationType.text = peNewAssessment.evaluationName
        lblEvaluator.text = peNewAssessment.customerName
        lblSiteName.text = peNewAssessment.siteName
        let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment.serverAssessmentId ?? "")

        
        if let isEMRequested = peNewAssessment.IsEMRequested {
            print(isEMRequested)
        }
        
        if let extndMicro = peNewAssessment.extndMicro {
            print(extndMicro)
        }
        
        if !Constants.isFromRejected {
            lblAction.text = "Submitted"
            if peNewAssessment.IsEMRequested == false {
                if peNewAssessment.extndMicro == false
                {
                    extendedMicroLbl.text = "No"
                    emstatus.text = "N/A"
                    
                    editBtn.isHidden = true
                    editImage.isHidden = true
                    editBtn.isUserInteractionEnabled = false
                }
                else
                {
                    if peNewAssessment.sanitationValue == false
                    {
                        extendedMicroLbl.text = "N/A"
                        editBtn.isHidden = true
                        editImage.isHidden = true
                        editBtn.isUserInteractionEnabled = false
                        emstatus.text = "No"
                    }
                    else
                        
                    {
                        extendedMicroLbl.text = "Incomplete"
                        editBtn.isHidden = false
                        editImage.isHidden = false
                        editBtn.isUserInteractionEnabled = true
                        emstatus.text = "In Progress"
                    }
                    
                  
                }
                
            }
            else {
                extendedMicroLbl.text = "Completed"
                editBtn.isHidden = true
                editImage.isHidden = true
                editBtn.isUserInteractionEnabled = false
                if peNewAssessment.isEMRejected == true && peNewAssessment.isPERejected == false {
                    emstatus.text = "Rejected"
                }
                else if peNewAssessment.isEMRejected == false && peNewAssessment.isPERejected == false  {
                    emstatus.text = "Submitted"
                } else {
                    emstatus.text = "Submitted"
                }
              
            }
        }
        else {
            editBtn.isHidden = true
            editImage.isHidden = true
            
            
            if peNewAssessment.isPERejected == true && peNewAssessment.isEMRejected == true
            {
                emstatus.text = "Rejected"
                emRejectedComentBtn.isHidden = false
                lblAction.text = "Rejected"
                infoButton.isHidden = false
                
                if peNewAssessment.extndMicro == false{
                    extendedMicroLbl.text = "No"
                }
                else{
                    extendedMicroLbl.text = "Yes"
                }
            }
            else if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
            {
                emstatus.text = "Rejected"
                emRejectedComentBtn.isHidden = false
                lblAction.text = "Approved"
                infoButton.isHidden = true
                
                if peNewAssessment.extndMicro == false{
                    extendedMicroLbl.text = "No"
                }
                else{
                    extendedMicroLbl.text = "Yes"
                }
            }
            
            else if peNewAssessment.isPERejected == true && peNewAssessment.isEMRejected == false
            {
                lblAction.text = "Rejected"
                if peNewAssessment.sanitationValue == false{
                    extendedMicroLbl.text = "No"
                    emstatus.text = "N/A"
                }
                
            }
            
            else if peNewAssessment.IsEMRequested == false && peNewAssessment.sanitationValue == false
            {
                lblAction.text = "Rejected"
                if peNewAssessment.extndMicro == false{
                    extendedMicroLbl.text = "No"
                    emstatus.text = "N/A"
                }
            }
         
             else {
                 extendedMicroLbl.text = "No"
                 emstatus.text = "N/A"
                 emRejectedComentBtn.isHidden = true
            }
 
        }

        
        var AssessmentId = peNewAssessment.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = (peNewAssessment.serverAssessmentId as? NSString)!.integerValue
        }
        let sbId =  peNewAssessment.dataToSubmitID ?? ""
        let UniID = sbId
        var score = 0
        var DisplayId = peNewAssessment.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        var siteId = String(peNewAssessment.siteId ?? 0)
        
        var sID = peNewAssessment.siteId ?? 0
        sID = sID + 270101
        var dID = AssessmentId ?? 0
        dID = dID + 2903
        // DisplayId = "C-" + DisplayId! + String(sID) + String(dID)
        DisplayId = "C-" + UniID
        if !Constants.isFromRejected{
            lblAssessment.text = DisplayId
        }

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBACTIONS

//    @IBAction func idInfoClicked(sender: UIButton) {
//    }
    
    
}
