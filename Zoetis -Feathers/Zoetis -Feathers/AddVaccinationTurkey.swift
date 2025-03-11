//
//  AddVaccinationTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 15/03/18.
//  Copyright © 2018 Manish. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import ReachabilitySwift
import SystemConfiguration

class AddVaccinationTurkey: UIViewController, DropperDelegateTurkey, UITextFieldDelegate, feedPop {

    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        hatchMarekStrainLbl.text = contents
    }

    @IBOutlet weak var vaccinationPrgrmTextField: UITextField!
    @IBOutlet weak var hatcheryBtnOutlet: UIButton!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var fieldVaccinationOutlet: UIButton!
    var btnTag = NSInteger()
    var fieldVaccinatioDataAray = NSArray()
    var postingIdFromExisting = NSNumber()
    var postingIdFromExistingNavigate = String()
    var postingId = NSNumber()
    // MARK: - Hatchery Outlet

    @IBOutlet weak var hatcherView: UIView!
    @IBOutlet weak var hatchMarekStrainField: UITextField!
    @IBOutlet weak var ibdvMarekStrainField: UITextField!
    @IBOutlet weak var ibvMarekStrainField: UITextField!
    @IBOutlet weak var trtMarekStrainField: UITextField!
    @IBOutlet weak var ndvMarekStrainField: UITextField!
    @IBOutlet weak var poxMarekStrainField: UITextField!
    @IBOutlet weak var reoMarekStrainField: UITextField!
    @IBOutlet weak var stMarekStrainField: UITextField!
    @IBOutlet weak var ecoliMarekStrainField: UITextField!
    @IBOutlet weak var othersMarekStrainField: UITextField!

    // MARK: - Hatchery Outlet Label
    @IBOutlet weak var hatchMarekStrainLbl: UILabel!
    @IBOutlet weak var ibdvMarekStrainLbl: UILabel!
    @IBOutlet weak var ibvMarekStrainLbl: UILabel!
    @IBOutlet weak var trtMarekStrainLbl: UILabel!
    @IBOutlet weak var ndvMarekStrainLbl: UILabel!
    @IBOutlet weak var poxMarekStrainLbl: UILabel!
    @IBOutlet weak var reoMarekStrainLbl: UILabel!
    @IBOutlet weak var stMarekStrainLbl: UILabel!
    @IBOutlet weak var ecoliMarekStrainLbl: UILabel!
    @IBOutlet weak var othersMarekStrainLbl: UILabel!
    // MARK: - Hatchery Button Outlet
    @IBOutlet weak var hatchMarekRouteOutlet: UIButton!
    @IBOutlet weak var hatchIbdvRouteOutlet: UIButton!
    @IBOutlet weak var hatchibvRouteOutlet: UIButton!
    @IBOutlet weak var hatchTrtRouteOutlet: UIButton!
    @IBOutlet weak var hatchNdvRouteOutlet: UIButton!
    @IBOutlet weak var hatchPoxRouteOutlet: UIButton!
    @IBOutlet weak var hatchReoRouteOutlet: UIButton!
    @IBOutlet weak var hatchStRouteOutlet: UIButton!
    @IBOutlet weak var hatchEcoliRouteOutlet: UIButton!
    @IBOutlet weak var hatchOthersRouteOutlet: UIButton!

    // MARK: - Field Vaccination Outlet
    @IBOutlet weak var fieldVaccinationView: UIView!
    @IBOutlet weak var vacciIbdv1StrainField: UITextField!
    @IBOutlet weak var vacciIbdv2StrainField: UITextField!
    @IBOutlet weak var vacciIbv1StrainField: UITextField!
    @IBOutlet weak var vacciIbv2StrainField: UITextField!
    @IBOutlet weak var vacciTrtStrainField: UITextField!
    @IBOutlet weak var vacciTrt2StrainField: UITextField!
    @IBOutlet weak var vacciNdv1StrainField: UITextField!
    @IBOutlet weak var vacciNdv2StrainField: UITextField!
    @IBOutlet weak var vacciStStrainField: UITextField!
    @IBOutlet weak var vacciEcoliStrainField: UITextField!
    @IBOutlet weak var vacciOthersStrainField: UITextField!
    // MARK: - Field Vaccination Outlet Label
    @IBOutlet weak var vacciIbdv1StrainLbl: UILabel!
    @IBOutlet weak var vacciIbdv2StrainLbl: UILabel!
    @IBOutlet weak var vacciIbv1StrainLbl: UILabel!
    @IBOutlet weak var vacciIbv2StrainLbl: UILabel!
    @IBOutlet weak var vacciTrtStrainLbl: UILabel!
    @IBOutlet weak var vacciTrt2StrainLbl: UILabel!
    @IBOutlet weak var vacciNdv1StrainLbl: UILabel!
    @IBOutlet weak var vacciNdv2StrainLbl: UILabel!
    @IBOutlet weak var vacciStStrainLbl: UILabel!
    @IBOutlet weak var vacciEcoliStrainLbl: UILabel!
    @IBOutlet weak var vacciOthersStrainLbl: UILabel!

    // MARK: - Field Vaccination Outlet
    @IBOutlet weak var vacciIbdv1AgeField: UITextField!
    @IBOutlet weak var vacciIbdv2AgeField: UITextField!
    @IBOutlet weak var vacciIbv1AgeField: UITextField!
    @IBOutlet weak var vacciIbv2AgeField: UITextField!
    @IBOutlet weak var vacciTrtAgeField: UITextField!
    @IBOutlet weak var vacciTrt2AgeField: UITextField!
    @IBOutlet weak var vacciNdv1AgeField: UITextField!
    @IBOutlet weak var vacciNdv2AgeField: UITextField!
    @IBOutlet weak var vacciStAgeField: UITextField!
    @IBOutlet weak var vacciEcoliAgeField: UITextField!
    @IBOutlet weak var vacciOthersAgeField: UITextField!

    // MARK: - Field Vaccination Button Outlet
    @IBOutlet weak var vacciIbdv1Outlet: UIButton!
    @IBOutlet weak var vacciIbdv2Outlet: UIButton!
    @IBOutlet weak var vacciIbv1Outlet: UIButton!
    @IBOutlet weak var vacciIbv2Outlet: UIButton!
    @IBOutlet weak var vacciTrtOutlet: UIButton!
    @IBOutlet weak var vacciTrt2Outlet: UIButton!
    @IBOutlet weak var vacciNdv1Outlet: UIButton!
    @IBOutlet weak var vacciNdv2Outlet: UIButton!
    @IBOutlet weak var vacciStOutlet: UIButton!
    @IBOutlet weak var vacciEcoliOutlet: UIButton!
    @IBOutlet weak var vacciOthersOutlet: UIButton!

    @IBOutlet var mainView: UIView!
    var hatecheryArray = NSArray()
    var finalizeValue = NSNumber()
    @IBOutlet weak var doneBTNoutlet: UIButton!
    var isClickOnAnyField = Bool()
    var lngId = NSInteger()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var typeMarek: UILabel!
    @IBOutlet weak var typeIbdv: UILabel!
    @IBOutlet weak var typeIbv: UILabel!
    @IBOutlet weak var typeTrt: UILabel!
    @IBOutlet weak var typeNdv: UILabel!
    @IBOutlet weak var typePox: UILabel!
    @IBOutlet weak var typeReo: UILabel!
    @IBOutlet weak var typeSt: UILabel!
    @IBOutlet weak var typeEColi: UILabel!
    @IBOutlet weak var typeOthers: UILabel!

    @IBOutlet weak var type0: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var type3: UILabel!
    @IBOutlet weak var type4: UILabel!
    @IBOutlet weak var type5: UILabel!
    @IBOutlet weak var type6: UILabel!
    @IBOutlet weak var type7: UILabel!
    @IBOutlet weak var type8: UILabel!
    @IBOutlet weak var type9: UILabel!
    @IBOutlet weak var type10: UILabel!

    var dataArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        if lngId == 5 {
            //lblHatchery.text = "Criadero"
            //lblFieldVacii.text = "Vacunación de campo"
        }
        hatecheryArray =  CoreDataHandlerTurkey().fetchRouteTurkeyLngId(lngId: 1)
        self.buttonLayoutSet()
        fieldVaccinationView.isHidden = true
        hatcherView.isHidden = false
        isClickOnAnyField = false

        if vacciIbdv1StrainField.text == ""{

            vacciIbdv1AgeField.isUserInteractionEnabled = false
        }
        if vacciIbdv2StrainField.text == ""{

            vacciIbdv2AgeField.isUserInteractionEnabled = false
        }
        if vacciIbv1StrainField.text == ""{

            vacciIbv1AgeField.isUserInteractionEnabled = false
        }
        if vacciIbv2StrainField.text == ""{

            vacciIbv2AgeField.isUserInteractionEnabled = false
        }

        if vacciTrtStrainField.text == ""{

            vacciTrtAgeField.isUserInteractionEnabled = false
        }
        if vacciTrt2StrainField.text == ""{

            vacciTrt2AgeField.isUserInteractionEnabled = false
        }

        if vacciNdv1StrainField.text == ""{

            vacciNdv1AgeField.isUserInteractionEnabled = false
        }
        if vacciNdv2StrainField.text == ""{

            vacciNdv2AgeField.isUserInteractionEnabled = false
        }

        if vacciStStrainField.text == ""{

            vacciStAgeField.isUserInteractionEnabled = false
        }
        if vacciEcoliStrainField.text == ""{

            vacciEcoliAgeField.isUserInteractionEnabled = false
        }

        if vacciOthersStrainField.text == ""{

            vacciOthersAgeField.isUserInteractionEnabled = false
        }
        self.textFieldEnable()
    }

    override func viewWillAppear(_ animated: Bool) {

        userNameLbl.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        if finalizeValue == 1 {

            doneBTNoutlet.isHidden = true
            hatcherView.isUserInteractionEnabled = false
            fieldVaccinationView.isUserInteractionEnabled = false
            vaccinationPrgrmTextField.isUserInteractionEnabled = false

        } else {
            doneBTNoutlet.isHidden = false
            hatcherView.isUserInteractionEnabled = true
            fieldVaccinationView.isUserInteractionEnabled = true
            vaccinationPrgrmTextField.isUserInteractionEnabled = true
        }
        buttonLayoutSet()
    }
    override func viewDidLayoutSubviews() {
        buttonLayoutSet()
    }

    @IBAction func tapOnHatcheryViewAction(_ sender: Any) {

        hatcherView.endEditing(true)
        fieldVaccinationView.endEditing(true)

        mainView.endEditing(true)
        hideDropDownTurkey()
    }

    @IBAction func tapVaccinationViewAction(_ sender: Any) {
        hideDropDownTurkey()

        mainView.endEditing(true)
        fieldVaccinationView.endEditing(true)
    }

    @IBAction func fieldVaccinationAction(_ sender: UIButton) {
        btnTag = 1

        hatcheryBtnOutlet.setImage(UIImage(named: "hatchery_unselected_btn"), for: UIControl.State())
        fieldVaccinationOutlet.setImage(UIImage(named: "field_vaccination_select_btn"), for: UIControl.State())
        hatcherView.isHidden = true
        fieldVaccinationView.isHidden = false
    }

    @IBAction func hatcheryBtnAction(_ sender: UIButton) {

        btnTag = 0
        hatcheryBtnOutlet.setImage(UIImage(named: "hatchery_selected_btn"), for: UIControl.State())
        fieldVaccinationOutlet.setImage(UIImage(named: "field_vaccination_unselect_btn"), for: UIControl.State())
        fieldVaccinationView.isHidden = true
        hatcherView.isHidden = false

    }

    @IBAction func doneBtnAction(_ sender: UIButton) {

        btnTag = 2
        allSaveData(btnTag)
    }

    @IBAction func bckBtnAction(_ sender: UIButton) {

        btnTag = 1
        allSaveData(btnTag)
    }

    @IBAction func hatchMarekRouteAction(_ sender: UIButton) {

        view.endEditing(true)
        if (hatchMarekStrainField.text == " " || hatchMarekStrainField.text == "") {
            hatchMarekRouteOutlet.isUserInteractionEnabled = false
        } else {
            showDropDownTurkey(sender, lblName: hatchMarekStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func hatchIbdvRouteAction(_ sender: UIButton) {
        view.endEditing(true)
        if (ibdvMarekStrainField.text == " " || ibdvMarekStrainField.text == "") {
            hatchIbdvRouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender, lblName: ibdvMarekStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func hatchIbvRouteAction(_ sender: UIButton) {
        view.endEditing(true)
        if (ibvMarekStrainField.text == " " || ibvMarekStrainField.text == "" ) {
            hatchibvRouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender, lblName: ibvMarekStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func hatchTrtRouteAction(_ sender: UIButton) {
        view.endEditing(true)
        if (trtMarekStrainField.text == " " || trtMarekStrainField.text == "" ) {
            hatchTrtRouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender, lblName: trtMarekStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func hatchNdvRouteAction(_ sender: UIButton) {
        view.endEditing(true)
        if (ndvMarekStrainField.text == " " || ndvMarekStrainField.text == "") {
            hatchNdvRouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender, lblName: ndvMarekStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func hatchPoxRouteAction(_ sender: UIButton) {
        view.endEditing(true)
        if (poxMarekStrainField.text == " " || poxMarekStrainField.text == "") {
            hatchPoxRouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender, lblName: poxMarekStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func hatchReoRouteAction(_ sender: UIButton) {
        view.endEditing(true)

        if (reoMarekStrainField.text == " " || reoMarekStrainField.text == "") {

            hatchReoRouteOutlet.isUserInteractionEnabled = false
        } else {
            showDropDownTurkey(sender, lblName: reoMarekStrainLbl, array: hatecheryArray)
            isClickOnAnyField = true
        }
    }

    @IBAction func hatchStRouteAction(_ sender: UIButton) {
        view.endEditing(true)

        if (stMarekStrainField.text == " " || stMarekStrainField.text == "") {

            hatchStRouteOutlet.isUserInteractionEnabled = false
        } else {
            showDropDownTurkey(sender, lblName: stMarekStrainLbl, array: hatecheryArray)
            isClickOnAnyField = true

        }
    }

    @IBAction func hatchEcoliRouteAction(_ sender: UIButton) {
        view.endEditing(true)
        if (ecoliMarekStrainField.text == " " || ecoliMarekStrainField.text == "") {
            hatchEcoliRouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender, lblName: ecoliMarekStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func hatchOtherRouteAction(_ sender: UIButton) {
        view.endEditing(true)
        if (othersMarekStrainField.text == " " || othersMarekStrainField.text == "") {
            hatchOthersRouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender, lblName: othersMarekStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }
    }

    // MARK: - Field Vaccination Button Action

    @IBAction func vacciIbdv1Strain(_ sender: Any) {

        view.endEditing(true)
        if (vacciIbdv1StrainField.text == " " || vacciIbdv1StrainField.text == "") {
            vacciIbdv1AgeField.isUserInteractionEnabled = false
            vacciIbdv1Outlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciIbdv1StrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }}

    @IBAction func vacciIbdv2Strain(_ sender: Any) {

        view.endEditing(true)
        if (vacciIbdv2StrainField.text == " " || vacciIbdv2StrainField.text == "") {
            vacciIbdv2AgeField.isUserInteractionEnabled = false
            vacciIbdv2Outlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciIbdv2StrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true

        }}

    @IBAction func vacciIbvStrain(_ sender: Any) {

        view.endEditing(true)
        if (vacciIbv1StrainField.text == " " || vacciIbv1StrainField.text == "") {
            vacciIbv1AgeField.isUserInteractionEnabled = false
            vacciIbv1Outlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciIbv1StrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true

        }}

    @IBAction func vacciIbv2Strain(_ sender: Any) {

        view.endEditing(true)
        if (vacciIbv2StrainField.text == " " || vacciIbv2StrainField.text == "") {
            vacciIbv2AgeField.isUserInteractionEnabled = false
            vacciIbv2Outlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciIbv2StrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }}
    @IBAction func vacciTrtStrain(_ sender: Any) {

        view.endEditing(true)
        if (vacciTrtStrainField.text == " " || vacciTrtStrainField.text == "") {
            vacciTrtAgeField.isUserInteractionEnabled = false
            vacciTrtOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciTrtStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true

        }}
    @IBAction func vacciTrt2Strain(_ sender: Any) {

        view.endEditing(true)
        if (vacciTrt2StrainField.text == " " || vacciTrt2StrainField.text == "") {
            vacciTrt2AgeField.isUserInteractionEnabled = false
            vacciTrt2Outlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciTrt2StrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true

        }}

    @IBAction func vacciNdvStrain(_ sender: Any) {

        view.endEditing(true)
        if (vacciNdv1StrainField.text == " " || vacciNdv1StrainField.text == "") {
            vacciNdv1AgeField.isUserInteractionEnabled = false
            vacciNdv1Outlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciNdv1StrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }}
    func textFieldEnable() {

        if (vacciTrtStrainField.text == " " || vacciTrtStrainField.text == "") {
            vacciTrtAgeField.isUserInteractionEnabled = false
            vacciTrtOutlet.isUserInteractionEnabled = false

        } else {
            vacciTrtAgeField.isUserInteractionEnabled = true

        }

        if (vacciIbdv1StrainField.text == " " || vacciIbdv1StrainField.text == "") {
            vacciIbdv1AgeField.isUserInteractionEnabled = false
            vacciIbdv1Outlet.isUserInteractionEnabled = false
        } else {
            vacciIbdv1AgeField.isUserInteractionEnabled = true
        }

        if (vacciIbdv2StrainField.text == " " || vacciIbdv2StrainField.text == "") {
            vacciIbdv2AgeField.isUserInteractionEnabled = false
            vacciIbdv2Outlet.isUserInteractionEnabled = false

        } else {
            vacciIbdv2AgeField.isUserInteractionEnabled = true
        }

        if (vacciIbv1StrainField.text == " " || vacciIbv1StrainField.text == "") {
            vacciIbv1AgeField.isUserInteractionEnabled = false
            vacciIbv1Outlet.isUserInteractionEnabled = false

        } else {
            vacciIbv1AgeField.isUserInteractionEnabled = true
        }

        if (vacciIbv2StrainField.text == " " || vacciIbv2StrainField.text == "") {
            vacciIbv2AgeField.isUserInteractionEnabled = false
            vacciIbv2Outlet.isUserInteractionEnabled = false
        } else {
            vacciIbv2AgeField.isUserInteractionEnabled = true
        }

        if (vacciTrt2StrainField.text == " " || vacciTrt2StrainField.text == "") {
            vacciTrt2AgeField.isUserInteractionEnabled = false
            vacciTrt2Outlet.isUserInteractionEnabled = false
        } else {
            vacciTrt2AgeField.isUserInteractionEnabled = true
        }

        if (vacciNdv1StrainField.text == " " || vacciNdv1StrainField.text == "") {
            vacciNdv1AgeField.isUserInteractionEnabled = false
            vacciNdv1Outlet.isUserInteractionEnabled = false
        } else {
            vacciNdv1AgeField.isUserInteractionEnabled = true
        }

        if (vacciNdv2StrainField.text == " " || vacciNdv2StrainField.text == "") {
            vacciNdv2AgeField.isUserInteractionEnabled = false
            vacciNdv2Outlet.isUserInteractionEnabled = false
        } else {
            vacciNdv2AgeField.isUserInteractionEnabled = true
        }

        if (vacciStStrainField.text == " " || vacciStStrainField.text == "") {
            vacciStAgeField.isUserInteractionEnabled = false
            vacciStOutlet.isUserInteractionEnabled = false
        } else {
            vacciStAgeField.isUserInteractionEnabled = true
        }

        if (vacciEcoliStrainField.text == " " || vacciEcoliStrainField.text == "") {
            vacciEcoliAgeField.isUserInteractionEnabled = false
            vacciEcoliOutlet.isUserInteractionEnabled = false
        } else {
            vacciEcoliAgeField.isUserInteractionEnabled = true
        }

        if (vacciOthersStrainField.text == " " || vacciOthersStrainField.text == "") {
            vacciOthersAgeField.isUserInteractionEnabled = false
            vacciOthersOutlet.isUserInteractionEnabled = false
        } else {
            vacciOthersAgeField.isUserInteractionEnabled = true
        }
    }

    @IBAction func vacciNdv2Strain(_ sender: Any) {

        view.endEditing(true)
        if (vacciNdv2StrainField.text == " " || vacciNdv2StrainField.text == "") {
            vacciNdv2AgeField.isUserInteractionEnabled = false
            vacciNdv2Outlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciNdv2StrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }}

    @IBAction func vacciSTStrain(_ sender: Any) {

        view.endEditing(true)
        if (vacciStStrainField.text == " " || vacciStStrainField.text == "") {
            vacciStAgeField.isUserInteractionEnabled = false
            vacciStOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciStStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true
        }}

    @IBAction func vacciEcoliStrain(_ sender: Any) {

        view.endEditing(true)
        if (vacciEcoliStrainField.text == " " || vacciEcoliStrainField.text == "") {
            vacciEcoliAgeField.isUserInteractionEnabled = false
            vacciEcoliOutlet.isUserInteractionEnabled = false

        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciEcoliStrainLbl, array: hatecheryArray  )
            isClickOnAnyField = true

        }}

    @IBAction func vacciOthersStrain(_ sender: Any) {
        view.endEditing(true)
        if (vacciOthersStrainField.text == " " || vacciOthersStrainField.text == "") {
            vacciOthersAgeField.isUserInteractionEnabled = false
            vacciOthersOutlet.isUserInteractionEnabled = false
        } else {
            showDropDownTurkey(sender as! UIButton, lblName: vacciOthersStrainLbl, array: hatecheryArray)
            isClickOnAnyField = true

        }}

    func textFieldDidEndEditing(_ textField: UITextField) {

        if (vacciOthersStrainField.text?.isEmpty == false) {
            vacciOthersOutlet.isUserInteractionEnabled = true
            vacciOthersAgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciNdv2StrainField.text?.isEmpty == false) {
            vacciNdv2Outlet.isUserInteractionEnabled = true
            vacciNdv2AgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciNdv1StrainField.text?.isEmpty == false) {
            vacciNdv1Outlet.isUserInteractionEnabled = true
            vacciNdv1AgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciTrt2StrainField.text?.isEmpty == false) {
            vacciTrt2AgeField.isUserInteractionEnabled = true
            vacciTrt2Outlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciTrtStrainField.text?.isEmpty == false) {
            vacciTrtAgeField.isUserInteractionEnabled = true
            vacciTrtOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciIbv2StrainField.text?.isEmpty == false) {
            vacciIbv2Outlet.isUserInteractionEnabled = true
            vacciIbv2AgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true

        }
        if (vacciIbdv2StrainField.text?.isEmpty == false) {
            vacciIbdv2Outlet.isUserInteractionEnabled = true
            vacciIbdv2AgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciIbv1StrainField.text?.isEmpty == false) {
            vacciIbv1Outlet.isUserInteractionEnabled = true
            vacciIbv1AgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciIbdv1StrainField.text?.isEmpty == false) {
            vacciIbdv1Outlet.isUserInteractionEnabled = true
            vacciIbdv1AgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (othersMarekStrainField.text?.isEmpty == false ) {
            hatchOthersRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (reoMarekStrainField.text?.isEmpty == false ) {
            hatchReoRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (poxMarekStrainField.text?.isEmpty == false ) {
            hatchPoxRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ndvMarekStrainField.text?.isEmpty == false ) {
            hatchNdvRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (trtMarekStrainField.text?.isEmpty == false ) {
            hatchTrtRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ibvMarekStrainField.text?.isEmpty == false ) {
            hatchibvRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ibvMarekStrainField.text?.isEmpty == false ) {
            hatchIbdvRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (hatchMarekStrainField.text?.isEmpty == false ) {
            hatchMarekRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ibvMarekStrainField.text?.isEmpty == false ) {
            hatchibvRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (stMarekStrainField.text?.isEmpty == false ) {
            hatchStRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ecoliMarekStrainField.text?.isEmpty == false ) {
            hatchEcoliRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciStStrainField.text?.isEmpty == false ) {
            vacciStOutlet.isUserInteractionEnabled = true
            vacciStAgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciEcoliStrainField.text?.isEmpty == false ) {
            vacciEcoliOutlet.isUserInteractionEnabled = true
            vacciEcoliAgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (vacciOthersStrainField.text?.isEmpty == false ) {
            vacciOthersOutlet.isUserInteractionEnabled = true
            vacciOthersAgeField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
    }

    ///////////////////////////////////////////
    func allSaveData( _ btnTag: Int) {
        var trimmedString = vaccinationPrgrmTextField.text!.trimmingCharacters(in: .whitespaces)
        trimmedString = trimmedString.replacingOccurrences(of: ".", with: "", options:
            NSString.CompareOptions.literal, range: nil)
        vaccinationPrgrmTextField.text = trimmedString
        if trimmedString == ""{
            if btnTag == 1 {

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.isDoneClick = true
                self.navigationController?.popViewController(animated: true)

            } else {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please enter the vaccination program.", comment: ""))
            }
        } else {
            if isClickOnAnyField == true {
                isClickOnAnyField = false

                for i in 0..<10 {

                    if i == 0 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeMarek.text!, strain: hatchMarekStrainField.text!, route: hatchMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 1 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeIbdv.text!, strain: ibdvMarekStrainField.text!, route: ibdvMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 2 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeIbv.text!, strain: ibvMarekStrainField.text!, route: ibvMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)                //

                    } else if i == 3 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeTrt.text!, strain: trtMarekStrainField.text!, route: trtMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)                //

                    } else if i == 4 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeNdv.text!, strain: ndvMarekStrainField.text!, route: ndvMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 5 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typePox.text!, strain: poxMarekStrainField.text!, route: poxMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 6 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeReo.text!, strain: reoMarekStrainField.text!, route: reoMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 7 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeSt.text!, strain: stMarekStrainField.text!, route: stMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 8 {
                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeEColi.text!, strain: ecoliMarekStrainField.text!, route: ecoliMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 9 {

                        CoreDataHandlerTurkey().saveFieldVacinationInDatabaseTurkey(typeOthers.text!, strain: othersMarekStrainField.text!, route: othersMarekStrainLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    }
                    ////print("value of i = \(i)")
                }

                /////////Hatchery////////

                for i in 0..<11 {

                    if i == 0 {

                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type0.text!, strain: vacciIbdv1StrainField.text!, route: vacciIbdv1StrainLbl.text!, age: vacciIbdv1AgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 1 {
                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type1.text!, strain: vacciIbdv2StrainField.text!, route: vacciIbdv2StrainLbl.text!, age: vacciIbdv2AgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 2 {

                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type2.text!, strain: vacciIbv1StrainField.text!, route: vacciIbv1StrainLbl.text!, age: vacciIbv1AgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 3 {

                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type3.text!, strain: vacciIbv2StrainField.text!, route: vacciIbv2StrainLbl.text!, age: vacciIbv2AgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 4 {

                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type4.text!, strain: vacciTrtStrainField.text!, route: vacciTrtStrainLbl.text!, age: vacciTrtAgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 5 {

                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type5.text!, strain: vacciTrt2StrainField.text!, route: vacciTrt2StrainLbl.text!, age: vacciTrt2AgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 6 {
                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type6.text!, strain: vacciNdv1StrainField.text!, route: vacciNdv1StrainLbl.text!, age: vacciNdv1AgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 7 {
                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type7.text!, strain: vacciNdv2StrainField.text!, route: vacciNdv2StrainLbl.text!, age: vacciNdv2AgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 8 {
                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type8.text!, strain: vacciStStrainField.text!, route: vacciStStrainLbl.text!, age: vacciStAgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 9 {

                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type9.text!, strain: vacciEcoliStrainField.text!, route: vacciEcoliStrainLbl.text!, age: vacciEcoliAgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 10 {

                        CoreDataHandlerTurkey().saveHatcheryVacinationInDatabaseTurkey(type10.text!, strain: vacciOthersStrainField.text!, route: vacciOthersStrainLbl.text!, age: vacciOthersAgeField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: vaccinationPrgrmTextField.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    }
                }

                CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(postingId)

                UserDefaults.standard.set(vaccinationPrgrmTextField.text!, forKey: "vaci")
                UserDefaults.standard.synchronize()
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.isDoneClick = true
            self.navigationController?.popViewController(animated: true)

        }
        appDelegate.sendFeedVariable = "vaccination"
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        DropperTurkey.sharedInstance.hideWithAnimation(0.1)

        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        DropperTurkey.sharedInstance.hideWithAnimation(0.1)

        if (textField ==  hatchMarekStrainField ) {
            hatchMarekStrainField.returnKeyType = UIReturnKeyType.done
        } else {
            hatchMarekStrainField.returnKeyType = UIReturnKeyType.done
            ibdvMarekStrainField.returnKeyType = UIReturnKeyType.done
            ibvMarekStrainField.returnKeyType = UIReturnKeyType.done
            trtMarekStrainField.returnKeyType = UIReturnKeyType.done
            ndvMarekStrainField.returnKeyType = UIReturnKeyType.done
            poxMarekStrainField.returnKeyType = UIReturnKeyType.done
            reoMarekStrainField.returnKeyType = UIReturnKeyType.done
            stMarekStrainField.returnKeyType = UIReturnKeyType.done
            ecoliMarekStrainField.returnKeyType = UIReturnKeyType.done
            othersMarekStrainField.returnKeyType = UIReturnKeyType.done
            vaccinationPrgrmTextField.returnKeyType = UIReturnKeyType.done

            vacciIbdv1StrainField.returnKeyType = UIReturnKeyType.done
            vacciIbdv2StrainField.returnKeyType = UIReturnKeyType.done
            vacciIbv1StrainField.returnKeyType = UIReturnKeyType.done
            vacciIbv2StrainField.returnKeyType = UIReturnKeyType.done
            vacciTrtStrainField.returnKeyType = UIReturnKeyType.done
            vacciTrt2StrainField.returnKeyType = UIReturnKeyType.done
            vacciNdv1StrainField.returnKeyType = UIReturnKeyType.done
            vacciNdv2StrainField.returnKeyType = UIReturnKeyType.done
            vacciStStrainField.returnKeyType = UIReturnKeyType.done
            vacciEcoliStrainField.returnKeyType = UIReturnKeyType.done
            vacciOthersStrainField.returnKeyType = UIReturnKeyType.done

            vacciIbdv1AgeField.returnKeyType =  UIReturnKeyType.done
            vacciIbdv2AgeField.returnKeyType =  UIReturnKeyType.done
            vacciIbv1AgeField.returnKeyType =   UIReturnKeyType.done
            vacciIbv2AgeField.returnKeyType =   UIReturnKeyType.done
            vacciTrtAgeField.returnKeyType =    UIReturnKeyType.done
            vacciTrt2AgeField.returnKeyType =   UIReturnKeyType.done
            vacciNdv1AgeField.returnKeyType =   UIReturnKeyType.done
            vacciNdv2AgeField.returnKeyType =   UIReturnKeyType.done
            vacciStAgeField.returnKeyType =     UIReturnKeyType.done
            vacciEcoliAgeField.returnKeyType =  UIReturnKeyType.done
            vacciOthersAgeField.returnKeyType = UIReturnKeyType.done

        }

        if vacciIbdv1StrainField.text == "" {
            vacciIbdv1AgeField.isUserInteractionEnabled = false

        }
        if vacciIbdv2StrainField.text == "" {
            vacciIbdv2AgeField.isUserInteractionEnabled = false

        }
        if vacciIbv1StrainField.text == "" {
            vacciIbv1AgeField.isUserInteractionEnabled = false

        }
        if vacciIbv2StrainField.text == "" {
            vacciIbv2AgeField.isUserInteractionEnabled = false

        }
        if vacciTrtStrainField.text == "" {
            vacciTrtAgeField.isUserInteractionEnabled = false

        }
        if vacciTrt2StrainField.text == "" {
            vacciTrt2AgeField.isUserInteractionEnabled = false

        }
        if vacciNdv1StrainField.text == "" {
            vacciNdv1AgeField.isUserInteractionEnabled = false

        }
        if vacciNdv2StrainField.text == "" {
            vacciNdv2AgeField.isUserInteractionEnabled = false

        }
        if vacciStStrainField.text == "" {
            vacciStAgeField.isUserInteractionEnabled = false

        }
        if vacciEcoliStrainField.text == "" {
            vacciEcoliAgeField.isUserInteractionEnabled = false

        }
        print(vacciOthersStrainField.text)
        if vacciOthersStrainField.text == "" {
            vacciOthersAgeField.isUserInteractionEnabled = false

            self.vacciOthersAgeField.tintColor = .clear

        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        hatcherView.endEditing(true)
        fieldVaccinationView.endEditing(true)
        view.endEditing(true)
    }

    func animateView (_ movement: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        })
    }
    var exitPopUP: feedPopUpTurkey!

    func showExitAlertWith(msg: String, tag: Int) {

        exitPopUP = feedPopUpTurkey.loadFromNibNamed("feedPopUpTurkey") as! feedPopUpTurkey
        exitPopUP.lblFedPrgram.text = msg
        exitPopUP.tag = tag
        exitPopUP.lblFedPrgram.textAlignment = .center
        exitPopUP.delegatefeedPop = self
        exitPopUP.center = self.view.center
        self.view.addSubview(exitPopUP)

    }
    func yesBtnPop() {

    }
    //////
    func noBtnPop() {
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            // Update posting session
            CoreDataHandlerTurkey().updatePostingSessionOndashBoardTurkey(self.postingId as NSNumber, vetanatrionName: "", veterinarianId: 0, captureNec: 2)
            CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(self.postingId as NSNumber)
            CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(self.postingId as NSNumber)
        } else {
            CoreDataHandlerTurkey().deleteDataWithPostingIdTurkey(self.postingId as NSNumber)
            CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(self.postingId as NSNumber)
            CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(self.postingId as NSNumber)
        }
        for dashboard in (self.navigationController?.viewControllers)! {
            if dashboard.isKind(of: DashViewControllerTurkey.self) {
                self.navigationController?.popToViewController(dashboard, animated: true)
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
    var index = 10

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField.tag {

        case 11, 12, 13, 14, 15, 16, 17, 18, 19, 30, 31, 40, 50, 21, 22, 23, 24, 25, 26, 27, 28, 29, 20 :

            let aSet = CharacterSet(charactersIn: "0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            let maxLength = 3
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString

            return string == numberFiltered && newString.length <= maxLength

        case 1 : break

        default : break

        }
        isClickOnAnyField = true

        return true
    }

    func alertShow() {

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please enter strain.", comment: ""))
    }

    func allSessionArr() -> NSMutableArray {

        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionWithisSyncisTrueTurkey(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandlerTurkey().FetchNecropsystep1WithisSyncTurkey(true)
        let necArrWithoutPosting = NSMutableArray()

        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId {
                    necArrWithoutPosting.remove(c)
                }
            }
        }
        let allPostingSessionArr = NSMutableArray()

        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count {
            let pSession = postingArrWithAllData.object(at: i) as! PostingSessionTurkey
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }

        for i in 0..<necArrWithoutPosting.count {
            let nIdSession = necArrWithoutPosting.object(at: i) as! CaptureNecropsyDataTurkey
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }

        return allPostingSessionArr
    }
    // MARK: - Button Layout

    func buttonLayoutSet() {

        vacciIbdv1Outlet.layer.borderWidth = 1
        vacciIbdv1Outlet.layer.cornerRadius = 3.5
        vacciIbdv1Outlet.layer.borderColor = UIColor.black.cgColor

        vacciIbdv2Outlet.layer.borderWidth = 1
        vacciIbdv2Outlet.layer.cornerRadius = 3.5
        vacciIbdv2Outlet.layer.borderColor = UIColor.black.cgColor

        vacciIbv1Outlet.layer.borderWidth = 1
        vacciIbv1Outlet.layer.cornerRadius = 3.5
        vacciIbv1Outlet.layer.borderColor = UIColor.black.cgColor

        vacciIbv2Outlet.layer.borderWidth = 1
        vacciIbv2Outlet.layer.cornerRadius = 3.5
        vacciIbv2Outlet.layer.borderColor = UIColor.black.cgColor

        vacciTrtOutlet.layer.borderWidth = 1
        vacciTrtOutlet.layer.cornerRadius = 3.5
        vacciTrtOutlet.layer.borderColor = UIColor.black.cgColor

        vacciTrt2Outlet.layer.borderWidth = 1
        vacciTrt2Outlet.layer.cornerRadius = 3.5
        vacciTrt2Outlet.layer.borderColor = UIColor.black.cgColor

        vacciNdv1Outlet.layer.borderWidth = 1
        vacciNdv1Outlet.layer.cornerRadius = 3.5
        vacciNdv1Outlet.layer.borderColor = UIColor.black.cgColor

        vacciNdv2Outlet.layer.borderWidth = 1
        vacciNdv2Outlet.layer.cornerRadius = 3.5
        vacciNdv2Outlet.layer.borderColor = UIColor.black.cgColor

        vacciStOutlet.layer.borderWidth = 1
        vacciStOutlet.layer.cornerRadius = 3.5
        vacciStOutlet.layer.borderColor = UIColor.black.cgColor

        vacciEcoliOutlet.layer.borderWidth = 1
        vacciEcoliOutlet.layer.cornerRadius = 3.5
        vacciEcoliOutlet.layer.borderColor = UIColor.black.cgColor

        vacciOthersOutlet.layer.borderWidth = 1
        vacciOthersOutlet.layer.cornerRadius = 3.5
        vacciOthersOutlet.layer.borderColor = UIColor.black.cgColor

        hatchOthersRouteOutlet.layer.borderWidth = 1
        hatchOthersRouteOutlet.layer.cornerRadius = 3.5
        hatchOthersRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchStRouteOutlet.layer.borderWidth = 1
        hatchStRouteOutlet.layer.cornerRadius = 3.5
        hatchStRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchEcoliRouteOutlet.layer.borderWidth = 1
        hatchEcoliRouteOutlet.layer.cornerRadius = 3.5
        hatchEcoliRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchPoxRouteOutlet.layer.borderWidth = 1
        hatchPoxRouteOutlet.layer.cornerRadius = 3.5
        hatchPoxRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchReoRouteOutlet.layer.borderWidth = 1
        hatchReoRouteOutlet.layer.cornerRadius = 3.5
        hatchReoRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchMarekRouteOutlet.layer.borderWidth = 1
        hatchMarekRouteOutlet.layer.cornerRadius = 3.5
        hatchMarekRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchIbdvRouteOutlet.layer.borderWidth = 1
        hatchIbdvRouteOutlet.layer.cornerRadius = 3.5
        hatchIbdvRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchibvRouteOutlet.layer.borderWidth = 1
        hatchibvRouteOutlet.layer.cornerRadius = 3.5
        hatchibvRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchTrtRouteOutlet.layer.borderWidth = 1
        hatchTrtRouteOutlet.layer.cornerRadius = 3.5
        hatchTrtRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatchNdvRouteOutlet.layer.borderWidth = 1
        hatchNdvRouteOutlet.layer.cornerRadius = 3.5
        hatchNdvRouteOutlet.layer.borderColor = UIColor.black.cgColor

        vacciIbdv1AgeField.delegate = self
        vacciIbdv2AgeField.delegate = self
        vacciIbv1AgeField.delegate = self
        vacciIbv2AgeField.delegate = self
        vacciTrtAgeField.delegate = self
        vacciTrt2AgeField.delegate = self
        vacciNdv1AgeField.delegate = self
        vacciNdv2AgeField.delegate = self
        vacciStAgeField.delegate = self
        vacciEcoliAgeField.delegate = self
        vacciOthersAgeField.delegate = self

        hatchMarekStrainField.delegate = self
        ibdvMarekStrainField.delegate = self
        ibvMarekStrainField.delegate = self
        trtMarekStrainField.delegate = self
        ndvMarekStrainField.delegate = self
        poxMarekStrainField.delegate = self
        stMarekStrainField.delegate = self
        ecoliMarekStrainField.delegate = self
        othersMarekStrainField.delegate = self
        reoMarekStrainField.delegate = self
        vacciIbdv1StrainField.delegate = self
        vacciIbdv2StrainField.delegate = self
        vacciIbv1StrainField.delegate = self
        vacciIbv2StrainField.delegate = self
        vacciTrtStrainField.delegate = self
        vacciTrt2StrainField.delegate = self
        vacciNdv1StrainField.delegate = self
        vacciNdv2StrainField.delegate = self
        vacciStStrainField.delegate = self
        vacciEcoliStrainField.delegate = self
        vacciOthersStrainField.delegate = self

        let cusPadding1 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        hatchMarekStrainField.leftView = cusPadding1
        hatchMarekStrainField.leftViewMode = .always

        let cusPadding2 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        ibdvMarekStrainField.leftView = cusPadding2
        ibdvMarekStrainField.leftViewMode = .always

        let cusPadding3 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        ibvMarekStrainField.leftView = cusPadding3
        ibvMarekStrainField.leftViewMode = .always

        let cusPadding4 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        trtMarekStrainField.leftView = cusPadding4
        trtMarekStrainField.leftViewMode = .always

        let cusPadding5 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        ndvMarekStrainField.leftView = cusPadding5
        ndvMarekStrainField.leftViewMode = .always

        let cusPadding6 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        poxMarekStrainField.leftView = cusPadding6
        poxMarekStrainField.leftViewMode = .always

        let cusPadding7 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        stMarekStrainField.leftView = cusPadding7
        stMarekStrainField.leftViewMode = .always

        let cusPadding8 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        ecoliMarekStrainField.leftView = cusPadding8
        ecoliMarekStrainField.leftViewMode = .always

        let cusPadding9 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        othersMarekStrainField.leftView = cusPadding9
        othersMarekStrainField.leftViewMode = .always
        let cusPadding10 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        reoMarekStrainField.leftView = cusPadding10
        reoMarekStrainField.leftViewMode = .always

        let cusPadding11 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciIbdv1StrainField.leftView = cusPadding11
        vacciIbdv1StrainField.leftViewMode = .always

        let cusPadding12 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciIbdv2StrainField.leftView = cusPadding12
        vacciIbdv2StrainField.leftViewMode = .always

        let cusPadding13 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciIbv1StrainField.leftView = cusPadding13
        vacciIbv1StrainField.leftViewMode = .always

        let cusPadding14 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciIbv2StrainField.leftView = cusPadding14
        vacciIbv2StrainField.leftViewMode = .always

        let cusPadding15 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciTrtStrainField.leftView = cusPadding15
        vacciTrtStrainField.leftViewMode = .always

        let cusPadding16 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciTrt2StrainField.leftView = cusPadding16
        vacciTrt2StrainField.leftViewMode = .always

        let cusPadding17 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciNdv1StrainField.leftView = cusPadding17
        vacciNdv1StrainField.leftViewMode = .always

        let cusPadding18 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciNdv2StrainField.leftView = cusPadding18
        vacciNdv2StrainField.leftViewMode = .always

        let cusPadding19 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciStStrainField.leftView = cusPadding19
        vacciStStrainField.leftViewMode = .always

        let cusPadding20 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciEcoliStrainField.leftView = cusPadding20
        vacciEcoliStrainField.leftViewMode = .always

        let cusPadding21 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciOthersStrainField.leftView = cusPadding21
        vacciOthersStrainField.leftViewMode = .always

        let cusPadding22 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciIbdv1AgeField.leftView = cusPadding22
        vacciIbdv1AgeField.leftViewMode = .always

        let cusPadding23 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciIbdv2AgeField.leftView = cusPadding23
        vacciIbdv2AgeField.leftViewMode = .always

        let cusPadding24 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciIbv1AgeField.leftView = cusPadding24
        vacciIbv1AgeField.leftViewMode = .always

        let cusPadding25 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciIbv2AgeField.leftView = cusPadding25
        vacciIbv2AgeField.leftViewMode = .always

        let cusPadding26 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciTrtAgeField.leftView = cusPadding26
        vacciTrtAgeField.leftViewMode = .always

        let cusPadding27 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciTrt2AgeField.leftView = cusPadding27
        vacciTrt2AgeField.leftViewMode = .always

        let cusPadding28 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciNdv1AgeField.leftView = cusPadding28
        vacciNdv1AgeField.leftViewMode = .always

        let cusPadding29 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciNdv2AgeField.leftView = cusPadding29
        vacciNdv2AgeField.leftViewMode = .always

        let cusPadding30 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciStAgeField.leftView = cusPadding30
        vacciStAgeField.leftViewMode = .always

        let cusPadding31 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciEcoliAgeField.leftView = cusPadding31
        vacciEcoliAgeField.leftViewMode = .always

        let cusPadding32 = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vacciOthersAgeField.leftView = cusPadding32
        vacciOthersAgeField.leftViewMode = .always

        vacciIbdv1StrainField.resignFirstResponder()
        vacciIbdv2StrainField.resignFirstResponder()
        vacciIbv1StrainField.resignFirstResponder()
        vacciIbv2StrainField.resignFirstResponder()
        vacciTrtStrainField.resignFirstResponder()
        vacciTrt2StrainField.resignFirstResponder()
        vacciNdv1StrainField.resignFirstResponder()
        vacciNdv2StrainField.resignFirstResponder()
        vacciStStrainField.resignFirstResponder()
        vacciEcoliStrainField.resignFirstResponder()
        vacciOthersStrainField.resignFirstResponder()
        vacciIbdv1AgeField.resignFirstResponder()
        vacciIbdv2AgeField.resignFirstResponder()
        vacciIbv1AgeField.resignFirstResponder()
        vacciIbv2AgeField.resignFirstResponder()
        vacciTrtAgeField.resignFirstResponder()
        vacciTrt2AgeField.resignFirstResponder()
        vacciNdv1AgeField.resignFirstResponder()
        vacciNdv2AgeField.resignFirstResponder()
        vacciStAgeField.resignFirstResponder()
        vacciEcoliAgeField.resignFirstResponder()
        vacciOthersAgeField.resignFirstResponder()
        hatchMarekStrainField.resignFirstResponder()
        ibdvMarekStrainField.resignFirstResponder()
        ibvMarekStrainField.resignFirstResponder()
        trtMarekStrainField.resignFirstResponder()
        ndvMarekStrainField.resignFirstResponder()
        poxMarekStrainField.resignFirstResponder()
        reoMarekStrainField.resignFirstResponder()
        stMarekStrainField.resignFirstResponder()
        ecoliMarekStrainField.resignFirstResponder()
        othersMarekStrainField.resignFirstResponder()

        let cusPaddingView = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 20))
        vaccinationPrgrmTextField.leftView = cusPaddingView
        vaccinationPrgrmTextField.leftViewMode = .always

        if postingIdFromExistingNavigate == "Exting"{
            postingId = postingIdFromExisting
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId") as NSNumber
        }

        dataArray = CoreDataHandlerTurkey().fetchAddvacinationDataTurkey(postingId)
        if dataArray.count > 0 {

            for i in 0..<dataArray.count {

                vacciIbdv1StrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 0) as? String
                vacciIbdv2StrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 1) as? String
                vacciIbv1StrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 2) as? String
                vacciIbv2StrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 3) as? String
                vacciTrtStrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 4) as? String
                vacciTrt2StrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 5) as? String
                vacciNdv1StrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 6) as? String
                vacciNdv2StrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 7) as? String
                vacciStStrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 8) as? String
                vacciEcoliStrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 9) as? String
                vacciOthersStrainField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 10) as? String
                ///// age
                vacciIbdv1StrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 0) as? String
                vacciIbdv2StrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 1) as? String
                vacciIbv1StrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 2) as? String
                vacciIbv2StrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 3) as? String
                vacciTrtStrainLbl.text =  (dataArray.value(forKey: "route") as AnyObject).object(at: 4) as? String
                vacciTrt2StrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 5) as? String
                vacciNdv1StrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 6) as? String
                vacciNdv2StrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 7) as? String
                vacciStStrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 8) as? String
                vacciEcoliStrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 9) as? String
                vacciOthersStrainLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 10) as? String

                vacciIbdv1AgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 0) as? String
                vacciIbdv2AgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 1) as? String
                vacciIbv1AgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 2) as? String
                vacciIbv2AgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 3) as? String
                vacciTrtAgeField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 4) as? String
                vacciTrt2AgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 5) as? String
                vacciNdv1AgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 6) as? String
                vacciNdv2AgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 7) as? String
                vacciStAgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 8) as? String
                vacciEcoliAgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 9) as? String
                vacciOthersAgeField.text = (dataArray.value(forKey: "age") as AnyObject).object(at: 10) as? String
                vaccinationPrgrmTextField.text = (dataArray.value(forKey: "vaciNationProgram") as AnyObject).object(at: 0) as? String
            }
        }
        /************ Fetching all data  From Database **************************/

        if postingIdFromExistingNavigate == "Exting"{
            postingId = postingIdFromExisting
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")  as NSNumber
        }

        fieldVaccinatioDataAray = CoreDataHandlerTurkey().fetchFieldAddvacinationDataTurkey(postingId)
        if fieldVaccinatioDataAray.count > 0 {

            for i in 0..<fieldVaccinatioDataAray.count {

                hatchMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 0) as? String
                ibdvMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 1) as? String
                ibvMarekStrainField.text = (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 2) as? String
                trtMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 3) as? String
                ndvMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 4) as? String
                poxMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 5) as? String
                reoMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 6) as? String
                stMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 7) as? String
                ecoliMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 8) as? String
                othersMarekStrainField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 9) as? String

                hatchMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 0) as? String
                ibdvMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 1) as? String
                ibvMarekStrainLbl.text = (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 2) as? String
                trtMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 3) as? String
                ndvMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 4) as? String
                poxMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 5) as? String
                reoMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 6) as? String
                stMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 7) as? String
                ecoliMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 8) as? String
                othersMarekStrainLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 9) as? String
            }
        }
    }
}
