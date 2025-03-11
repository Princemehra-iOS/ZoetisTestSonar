//
//  VaccineMixerCell.swift
//  Zoetis -Feathers
//
//  Created by MobileProgramming on 11/10/22.
//

import UIKit

class VaccineMixerCell: UITableViewCell  {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var toggleImgView: UIImageView!
    @IBOutlet weak var vaccNameField: UITextField!
    @IBOutlet weak var vaccSelectBtn: UIButton!
    @IBOutlet weak var vaccDropImgView: UIImageView!
    @IBOutlet weak var certDateSelectBtn: UIButton!
    @IBOutlet weak var mixerSigImgView: UIImageView!
    @IBOutlet weak var fstSigImgView: UIImageView!
    @IBOutlet weak var calenderBtn: UIButton!
    
    // MARK: - VARIABLES
    
    var nameCompletion:((_ error: String?) -> Void)?
    var certDateCompletion:((_ error: Int) -> Void)?
    var checkBoxCompletion:((_ error: String?) -> Void)?
    var changedDateCompletion:((_ error: Int?) -> Void)?
    var certificateData:PECertificateData?
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        vaccNameField.setLeftPaddingPoints(10.0)
        vaccNameField.font = UIFont.systemFont(ofSize: 18)
        vaccNameField.layer.borderWidth = 1.0
        vaccNameField.layer.cornerRadius = vaccNameField.frame.size.height/2
        vaccNameField.layer.masksToBounds = true
        vaccNameField.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
        certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
    }
    
    func config(data:PECertificateData){
        self.vaccNameField.text = data.name
       
        self.certDateSelectBtn.setTitle(data.certificateDate, for: .normal)
        certificateData = data
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - IB ACTIONS
    
    @IBAction func toggleBtnAction(_ sender: Any) {
        checkBoxCompletion?(nil)
    }
    
    @IBAction func vaccMixerSelectAction(_ sender: Any) {
        nameCompletion?("")
    }
    
    @IBAction func certDateSelectAction(_ sender: UIButton) {
        
        if(certificateData?.certificateDate == "" ){
            certDateCompletion?(sender.tag)
        }
    }
    
    @IBAction func updateDateAction(_ sender: UIButton) {
        let  regionID = UserDefaults.standard.integer(forKey: "Regionid")
        if(regionID != 3){
            changedDateCompletion?(sender.tag)
        }
        
    }
    
}

