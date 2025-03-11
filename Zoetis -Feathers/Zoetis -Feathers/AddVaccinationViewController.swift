//  AddVaccinationViewController.swift
//  Zoetis -Feathers
//  Created by "" on 9/7/16.
//  Copyright © 2016 "". All rights reserved.

import UIKit
import CoreData
import Alamofire
import ReachabilitySwift
import SystemConfiguration

class AddVaccinationViewController: UIViewController, DropperDelegate, UITextFieldDelegate, popUPnavigation {

    var isClickOnAnyField = Bool()

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let objApiSync = ApiSync()
    @IBOutlet weak var syncCountLbl: UILabel!
    @IBOutlet var mainView: UIView!
    let buttonbg = UIButton()
    var exitPopUP: popUP!
    var addVaciArray = NSArray()
    var btnTag = NSInteger()
    var postingId = NSNumber()
    var postingIdFromExisting = NSNumber()
    var postingIdFromExistingNavigate = String()
    var finalizeValue = NSNumber()
    var btntag = Int()
    @IBOutlet weak var userNameLabel: UILabel!
    /**************************************/
    @IBOutlet weak var doneBTNoutlet: UIButton!
    @IBOutlet weak var lblIbvTitle: UILabel!
    @IBOutlet weak var lblNdvnew2Title: UILabel!
    @IBOutlet weak var lblOthersTitle: UILabel!
    @IBOutlet weak var ndvNew2: UITextField!
    @IBOutlet weak var otherStrain: UITextField!
    @IBOutlet weak var ndv2DisplayLabel: UILabel!
    @IBOutlet weak var otherDisplayLabel: UILabel!
    @IBOutlet weak var ndv2AgeTextField: UITextField!
    @IBOutlet weak var otherAgeTextField: UITextField!
    @IBOutlet weak var otherRouteOutlet: UIButton!
    @IBOutlet weak var ibvRouteTextFieldOutlet: UIButton!
    @IBOutlet weak var ibvStrainTextField: UITextField!
    @IBOutlet weak var ibvRouteTextField: UILabel!
    var lngId = NSInteger()
    var colorr: String!
    @IBOutlet weak var type0: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var type3: UILabel!
    @IBOutlet weak var type4: UILabel!
    @IBOutlet weak var type5: UILabel!
    @IBOutlet weak var type6: UILabel!
    @IBOutlet weak var typeMarek: UILabel!
    @IBOutlet weak var typeIbdv: UILabel!
    @IBOutlet weak var typeTrt: UILabel!
    @IBOutlet weak var typeNdv: UILabel!
    @IBOutlet weak var typePox: UILabel!
    @IBOutlet weak var typeReo: UILabel!
    @IBOutlet weak var typeOthers: UILabel!
    @IBOutlet weak var HatcheryEcoliRouteLbl: UILabel!
    @IBOutlet weak var hatcheryStRouteOutlet: UIButton!
    @IBOutlet weak var hatcheryEcoliRouteOutlet: UIButton!
    @IBOutlet weak var stLabel: UILabel!
    @IBOutlet weak var ecoliLbl: UILabel!
    @IBOutlet weak var lblHatchery: UILabel!
    @IBOutlet weak var lblFieldVacii: UILabel!
    @IBOutlet weak var stRouteFieldDisplayLbl: UILabel!
    @IBOutlet weak var eColiRouteFieldDisplayLbl: UILabel!
    @IBOutlet weak var ecoliFieldLbl: UILabel!
    @IBOutlet weak var stFieldVaccinationLbl: UILabel!

    ///////////// Field Vaccinationnn/////////
    @IBOutlet weak var fieldVaccinationView: UIView!
    @IBOutlet weak var ibdvStrainFieldTextField: UITextField!
    @IBOutlet weak var ibdv2StrainFieldTextField: UITextField!
    @IBOutlet weak var ibvStrainFieldTextField: UITextField!
    @IBOutlet weak var ibv2StrainFieldTextField: UITextField!
    @IBOutlet weak var trtStrainFieldTextField: UITextField!
    @IBOutlet weak var trt2StrainFieldTextField: UITextField!
    @IBOutlet weak var ndvStrainFieldTextField: UITextField!

    /////// fIELD aGE tEXTfIELD
    @IBOutlet weak var ibdvAgeTextField: UITextField!
    @IBOutlet weak var ibdv2AgeTextField: UITextField!
    @IBOutlet weak var ibvAgeTextField: UITextField!
    @IBOutlet weak var ibv2AgeTextField: UITextField!
    @IBOutlet weak var trtAgeTextField: UITextField!
    @IBOutlet weak var trt2AgeTextField: UITextField!
    @IBOutlet weak var ndvAgeTextField: UITextField!

    //// checkbox
    @IBOutlet weak var coccidiosisControl: UITextField!
    @IBOutlet weak var hatcheryBtnOutlet: UIButton!
    @IBOutlet weak var fieldVaccinationBtnOutlet: UIButton!

    ////// checkBoxbttn ///////
    @IBOutlet weak var marekCheckBoxOutlet: UIButton!
    @IBOutlet weak var ibdvCheckBoxOutlet: UIButton!
    @IBOutlet weak var ibdCheckBoxOutlet: UIButton!
    @IBOutlet weak var trtCheckBoxOutlet: UIButton!
    @IBOutlet weak var ndvCheckBoxOutlet: UIButton!
    @IBOutlet weak var poxCheckBoxOutlet: UIButton!
    @IBOutlet weak var reoCheckBoxOutlet: UIButton!
    @IBOutlet weak var othersCheckBoxOutlet: UIButton!
    @IBOutlet weak var innerView: UIView!

    /////////// TextField
    @IBOutlet weak var marekStrainTextField: UITextField!
    @IBOutlet weak var ibdvStrainTextField: UITextField!
    @IBOutlet weak var ibdStrainTextField: UITextField!
    @IBOutlet weak var trtStrainTextField: UITextField!
    @IBOutlet weak var ndvStrainTextField: UITextField!
    @IBOutlet weak var poxStrainTextField: UITextField!
    @IBOutlet weak var reoStrainTextField: UITextField!
    @IBOutlet weak var othersStrainTextField: UITextField!
    /*************************************************************/
    @IBOutlet weak var ibdvTextFieldNew: UITextField!
    @IBOutlet weak var TrtFieldNew: UITextField!
    @IBOutlet weak var ndvNew: UITextField!
    /*****************************************************************/
    ////////// label //////////////
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var ibdvLabel: UILabel!
    @IBOutlet weak var ibdLabel: UILabel!
    @IBOutlet weak var trtLabel: UILabel!
    @IBOutlet weak var ndvLabel: UILabel!
    @IBOutlet weak var poxLbL: UILabel!
    @IBOutlet weak var reoLabel: UILabel!
    @IBOutlet weak var othesLabel: UILabel!

    //////// Route label ////////
    @IBOutlet weak var routeLabel1: UILabel!
    @IBOutlet weak var routeLabel2: UILabel!
    @IBOutlet weak var routeLabel3: UILabel!
    @IBOutlet weak var routeLabel4: UILabel!
    @IBOutlet weak var routeLabel5: UILabel!
    @IBOutlet weak var routeLabel6: UILabel!
    @IBOutlet weak var routeLabel7: UILabel!

    @IBOutlet weak var marekDrinkingWaterBtnOutlet: UIButton!
    @IBOutlet weak var ibdvDrinkingWaterBtnnOutlet: UIButton!
    @IBOutlet weak var trtDrinkingWaterBtn: UIButton!
    @IBOutlet weak var ndvDrinkingWaterBtn: UIButton!
    @IBOutlet weak var poxDrinkingWaterbTN: UIButton!
    @IBOutlet weak var reoDrinkingWaterOutlet: UIButton!
    @IBOutlet weak var othersDrinkingWaterBtn: UIButton!

    @IBOutlet weak var ibdvRouteOutlet: UIButton!
    @IBOutlet weak var ibdv2RouteOutlet: UIButton!
    @IBOutlet weak var ibvRouteFieldOutlet: UIButton!
    @IBOutlet weak var ibv2RouteOutlet: UIButton!
    @IBOutlet weak var trtRouteOutlet: UIButton!
    @IBOutlet weak var trt2RouteFieldOutlet: UIButton!
    @IBOutlet weak var ndvRouteOutlet: UIButton!

    var asb: Bool!
    var arrayMutable = [ModelVacation]()

    var id: Int!
    var dataArray = NSArray()
    var fieldVaccinatioDataAray = NSArray()
    var hatcheryVaccinationObject = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        if lngId == 5 {
            lblHatchery.text = "Criadero"
            lblFieldVacii.text = "Vacunación de campo"
        }
        ibdvAgeTextField.isUserInteractionEnabled = false
        ibdv2AgeTextField.isUserInteractionEnabled = false
        ibvAgeTextField.isUserInteractionEnabled = false
        ibv2AgeTextField.isUserInteractionEnabled = false
        trtAgeTextField.isUserInteractionEnabled = false
        trt2AgeTextField.isUserInteractionEnabled = false
        ndvAgeTextField.isUserInteractionEnabled = false
        ndv2AgeTextField.isUserInteractionEnabled = false
        otherAgeTextField.isUserInteractionEnabled = false
        stAgeTextField.isUserInteractionEnabled = false
        ecoliAgeTEXTfield.isUserInteractionEnabled = false

        isClickOnAnyField = false

        let cusPaddingView = UIView(frame: CGRect(x: 20, y: 0, width: 10, height: 20))
        coccidiosisControl.leftView = cusPaddingView
        coccidiosisControl.leftViewMode = .always
        hatcheryBtnOutlet.layer.borderColor = UIColor.clear.cgColor

        ndv2AgeTextField.tag = 11
        otherAgeTextField.tag = 12
        ibdvAgeTextField.tag = 13
        ibdv2AgeTextField.tag = 14
        ibvAgeTextField.tag = 15
        ibv2AgeTextField.tag = 16
        trtAgeTextField.tag = 17
        trt2AgeTextField.tag = 18
        ecoliAgeTEXTfield.tag = 30
        stAgeTextField.tag = 31

        ndvAgeTextField.tag = 19
        ndvNew2.delegate = self
        otherStrain.delegate = self

        ibvRouteTextFieldOutlet.layer.borderWidth = 1
        ibvRouteTextFieldOutlet.layer.cornerRadius = 3.5
        ibvRouteTextFieldOutlet.layer.borderColor = UIColor.black.cgColor

        stRouteOutlet.layer.borderWidth = 1
        stRouteOutlet.layer.cornerRadius = 3.5
        stRouteOutlet.layer.borderColor = UIColor.black.cgColor

        ecolibtnOutlet.layer.borderWidth = 1
        ecolibtnOutlet.layer.cornerRadius = 3.5
        ecolibtnOutlet.layer.borderColor = UIColor.black.cgColor

        ndv2RouteBtnOutlet.layer.borderWidth = 1
        ndv2RouteBtnOutlet.layer.cornerRadius = 3.5
        ndv2RouteBtnOutlet.layer.borderColor = UIColor.black.cgColor

        otherRouteOutlet.layer.borderWidth = 1
        otherRouteOutlet.layer.cornerRadius = 3.5
        otherRouteOutlet.layer.borderColor = UIColor.black.cgColor

        ibdvRouteOutlet.layer.borderWidth = 1
        ibdvRouteOutlet.layer.cornerRadius = 3.5
        ibdvRouteOutlet.layer.borderColor = UIColor.black.cgColor

        ibdv2RouteOutlet.layer.borderWidth = 1
        ibdv2RouteOutlet.layer.cornerRadius = 3.5
        ibdv2RouteOutlet.layer.borderColor = UIColor.black.cgColor

        ibvRouteFieldOutlet.layer.borderWidth = 1
        ibvRouteFieldOutlet.layer.cornerRadius = 3.5
        ibvRouteFieldOutlet.layer.borderColor = UIColor.black.cgColor

        ibv2RouteOutlet.layer.borderWidth = 1
        ibv2RouteOutlet.layer.cornerRadius = 3.5
        ibv2RouteOutlet.layer.borderColor = UIColor.black.cgColor

        trtRouteOutlet.layer.borderWidth = 1
        trtRouteOutlet.layer.cornerRadius = 3.5
        trtRouteOutlet.layer.borderColor = UIColor.black.cgColor

        trt2RouteFieldOutlet.layer.borderWidth = 1
        trt2RouteFieldOutlet.layer.cornerRadius = 3.5
        trt2RouteFieldOutlet.layer.borderColor = UIColor.black.cgColor

        ndvRouteOutlet.layer.borderWidth = 1
        ndvRouteOutlet.layer.cornerRadius = 3.5
        ndvRouteOutlet.layer.borderColor = UIColor.black.cgColor

        marekDrinkingWaterBtnOutlet.layer.borderWidth = 1
        marekDrinkingWaterBtnOutlet.layer.cornerRadius = 3.5
        marekDrinkingWaterBtnOutlet.layer.borderColor = UIColor.black.cgColor
        ibdvDrinkingWaterBtnnOutlet.layer.borderWidth = 1
        ibdvDrinkingWaterBtnnOutlet.layer.cornerRadius = 3.5
        ibdvDrinkingWaterBtnnOutlet.layer.borderColor = UIColor.black.cgColor

        hatcheryEcoliRouteOutlet.layer.borderWidth = 1
        hatcheryEcoliRouteOutlet.layer.cornerRadius = 3.5
        hatcheryEcoliRouteOutlet.layer.borderColor = UIColor.black.cgColor

        hatcheryStRouteOutlet.layer.borderWidth = 1
        hatcheryStRouteOutlet.layer.cornerRadius = 3.5
        hatcheryStRouteOutlet.layer.borderColor = UIColor.black.cgColor

        trtDrinkingWaterBtn.layer.borderWidth = 1
        trtDrinkingWaterBtn.layer.cornerRadius = 3.5
        trtDrinkingWaterBtn.layer.borderColor = UIColor.black.cgColor
        ndvDrinkingWaterBtn.layer.borderWidth = 1
        ndvDrinkingWaterBtn.layer.cornerRadius = 3.5
        ndvDrinkingWaterBtn.layer.borderColor = UIColor.black.cgColor

        poxDrinkingWaterbTN.layer.borderWidth = 1
        poxDrinkingWaterbTN.layer.cornerRadius = 3.5
        poxDrinkingWaterbTN.layer.borderColor = UIColor.black.cgColor

        reoDrinkingWaterOutlet.layer.borderWidth = 1
        reoDrinkingWaterOutlet.layer.cornerRadius = 3.5
        reoDrinkingWaterOutlet.layer.borderColor = UIColor.black.cgColor

        othersDrinkingWaterBtn.layer.borderWidth = 1
        othersDrinkingWaterBtn.layer.cornerRadius = 3.5
        othersDrinkingWaterBtn.layer.borderColor = UIColor.black.cgColor

        fieldVaccinationBtnOutlet.layer.borderColor = UIColor.gray.cgColor

        addVaciArray =  CoreDataHandler().fetchRouteLngId(lngId: lngId as NSNumber)

        ////print(addVaciArray)
        ibvStrainTextField.delegate = self
        ndvStrainTextField.delegate = self
        trtStrainTextField.delegate = self
        otherAgeTextField.delegate = self
        ndv2AgeTextField.delegate = self

        // ibdvStrainFieldTextField.delegate = self
        ibdv2StrainFieldTextField.delegate = self

        ibvStrainFieldTextField.delegate = self
        ibv2StrainFieldTextField.delegate = self

        // trtStrainFieldTextField.delegate = self
        trt2StrainFieldTextField.delegate = self

        // ndvStrainFieldTextField.delegate = self

        otherStrain.resignFirstResponder()
        /////// fIELD aGE tEXTfIELD
        ibdvAgeTextField.delegate = self
        ibdv2AgeTextField.delegate = self
        ibvAgeTextField.delegate = self
        ibv2AgeTextField.delegate = self
        trtAgeTextField.delegate = self
        trt2AgeTextField.delegate = self
        ndvAgeTextField.delegate = self
        marekStrainTextField.delegate = self
        ibdvStrainTextField.delegate = self
        poxStrainTextField.delegate = self
        reoStrainTextField.delegate = self
        othersStrainTextField.delegate = self
        coccidiosisControl.delegate = self

        self.ibdv2StrainFieldTextField.resignFirstResponder()
        self.ibvStrainFieldTextField.resignFirstResponder()
        self.ibv2StrainFieldTextField.resignFirstResponder()
        self.trt2StrainFieldTextField.resignFirstResponder()
        ibdvAgeTextField.resignFirstResponder()
        ibdv2AgeTextField.resignFirstResponder()
        ibvAgeTextField.resignFirstResponder()
        ibv2AgeTextField.resignFirstResponder()
        trtAgeTextField.resignFirstResponder()
        trt2AgeTextField.resignFirstResponder()
        marekStrainTextField.resignFirstResponder()
        ibdvStrainTextField.resignFirstResponder()
        ndvAgeTextField.resignFirstResponder()
        poxStrainTextField.resignFirstResponder()
        reoStrainTextField.resignFirstResponder()
        othersStrainTextField.resignFirstResponder()
        ibvStrainTextField.resignFirstResponder()
        ndvStrainTextField.resignFirstResponder()
        trtStrainTextField.resignFirstResponder()
        otherAgeTextField.resignFirstResponder()
        ndv2AgeTextField.resignFirstResponder()
        coccidiosisControl.resignFirstResponder()
        ndvNew2.resignFirstResponder()

        ecoliAgeTEXTfield.resignFirstResponder()
        eColiStrainTextField.resignFirstResponder()
        stHatcheryaStrainTextField.resignFirstResponder()
        eColiHatcheryStrainText.resignFirstResponder()
        stAgeTextField.resignFirstResponder()
        stStrainTextField.resignFirstResponder()

        fieldVaccinationView.isHidden = true

        /************ Fetching all data  From Database **************************/

        if postingIdFromExistingNavigate == "Exting"{
            postingId = postingIdFromExisting
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId") as NSNumber
        }

        dataArray  =  CoreDataHandler().fetchAddvacinationData(postingId)
        /**********************************************************************/
        if dataArray.count > 0 {

            for _ in 0..<dataArray.count {

                ibdvTextFieldNew.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 0) as? String
                ibdv2StrainFieldTextField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 1) as? String
                ibvStrainFieldTextField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 2) as? String
                ibv2StrainFieldTextField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 3) as? String
                TrtFieldNew.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 4) as? String
                trt2StrainFieldTextField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 5) as? String
                ndvNew.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 6) as? String
                ndvNew2.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 7) as? String
                stStrainTextField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 8) as? String
                eColiStrainTextField.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 9) as? String
                otherStrain.text =  (dataArray.value(forKey: "strain") as AnyObject).object(at: 10) as? String
                ///// age

                ibdvAgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 0) as? String
                ibdv2AgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 1) as? String
                ibvAgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 2) as? String
                ibv2AgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 3) as? String
                trtAgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 4) as? String
                trt2AgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 5) as? String
                ndvAgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 6) as? String
                ndv2AgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 7) as? String
                stAgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 8) as? String
                ecoliAgeTEXTfield.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 9) as? String
                otherAgeTextField.text =  (dataArray.value(forKey: "age") as AnyObject).object(at: 10) as? String

                routeLabel1.text =  (dataArray.value(forKey: "route") as AnyObject).object(at: 0) as? String
                routeLabel2.text =  (dataArray.value(forKey: "route") as AnyObject).object(at: 1) as? String
                routeLabel3.text =  (dataArray.value(forKey: "route") as AnyObject).object(at: 2) as? String
                routeLabel4.text =  (dataArray.value(forKey: "route") as AnyObject).object(at: 3) as? String
                routeLabel5.text =  (dataArray.value(forKey: "route") as AnyObject).object(at: 4) as? String
                routeLabel6.text =  (dataArray.value(forKey: "route") as AnyObject).object(at: 5) as? String
                routeLabel7.text =  (dataArray.value(forKey: "route") as AnyObject).object(at: 6) as? String
                ndv2DisplayLabel.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 7) as? String
                stRouteFieldDisplayLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 8) as? String
                eColiRouteFieldDisplayLbl.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 9) as? String
                otherDisplayLabel.text = (dataArray.value(forKey: "route") as AnyObject).object(at: 10) as? String

                coccidiosisControl.text = (dataArray.value(forKey: "vaciNationProgram") as AnyObject).object(at: 0) as? String

            }

            //////print("fetch all \(arrResults)")
        }

        /************ Fetching all data  From Database **************************/

        if postingIdFromExistingNavigate == "Exting"{
            postingId = postingIdFromExisting
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")  as NSNumber

        }

        fieldVaccinatioDataAray  =   CoreDataHandler().fetchFieldAddvacinationData(postingId)

        /**********************************************************************/
        if fieldVaccinatioDataAray.count > 0 {

            for _ in 0..<fieldVaccinatioDataAray.count {

                ////print(fieldVaccinatioDataAray)

                marekStrainTextField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 0) as? String
                ibdvStrainTextField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 1) as? String
                ibvStrainTextField.text = (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 2) as? String
                trtStrainTextField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 3) as? String
                ndvStrainTextField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 4) as? String
                poxStrainTextField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 5) as? String
                reoStrainTextField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 6) as? String
                stHatcheryaStrainTextField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 7) as? String
                eColiHatcheryStrainText.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 8) as? String
                othersStrainTextField.text =  (fieldVaccinatioDataAray.value(forKey: "strain") as AnyObject).object(at: 9) as? String

                markLabel.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 0) as? String

                ibdvLabel.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 1) as? String
                ibvRouteTextField.text = (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 2) as? String
                // ibdLabel.text =  fieldVaccinatioDataAray.valueForKey("route").objectAtIndex(2) as? String
                trtLabel.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 3) as? String
                ndvLabel.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 4) as? String
                poxLbL.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 5) as? String
                reoLabel.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 6) as? String
                hatcheryStRouteLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 7) as? String
                HatcheryEcoliRouteLbl.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 8) as? String
                othesLabel.text =  (fieldVaccinatioDataAray.value(forKey: "route") as AnyObject).object(at: 9) as? String
            }

            //////print("fetch all \(arrResults)")
        }

        // Do any additional setup after loading the view.

        self.textFieldEnable()
    }
    func textFieldEnable() {

        if (ibdvTextFieldNew.text == " " || ibdvTextFieldNew.text == "") {
            ibdvAgeTextField.isUserInteractionEnabled = false
            ibdvRouteOutlet.isUserInteractionEnabled = false
        } else {
            ibdvAgeTextField.isUserInteractionEnabled = true
        }

        if (ibdv2StrainFieldTextField.text == " " || ibdv2StrainFieldTextField.text == "") {
            ibdv2AgeTextField.isUserInteractionEnabled = false
            ibdv2RouteOutlet.isUserInteractionEnabled = false
        } else {
            ibdv2AgeTextField.isUserInteractionEnabled = true
        }

        if (ibvStrainFieldTextField.text == " " || ibvStrainFieldTextField.text == "") {

            ibvRouteFieldOutlet.isUserInteractionEnabled = false
            ibvAgeTextField.isUserInteractionEnabled = false

        } else {
            ibvAgeTextField.isUserInteractionEnabled = true
        }

        if (ibv2StrainFieldTextField.text == " " || ibv2StrainFieldTextField.text == "") {
            ibv2RouteOutlet.isUserInteractionEnabled = false
            ibv2AgeTextField.isUserInteractionEnabled = false

        } else {
            ibv2AgeTextField.isUserInteractionEnabled = true
        }

        if (TrtFieldNew.text == " " || TrtFieldNew.text == "") {

            trtRouteOutlet.isUserInteractionEnabled = false
            trtAgeTextField.isUserInteractionEnabled = false

        } else {

            trtAgeTextField.isUserInteractionEnabled = true
        }

        if (trt2StrainFieldTextField.text == " " || trt2StrainFieldTextField.text == "") {
            trt2AgeTextField.isUserInteractionEnabled = false
            trt2RouteFieldOutlet.isUserInteractionEnabled = false

        } else {
            trt2AgeTextField.isUserInteractionEnabled = true
        }

        if (ndvNew.text == " " || ndvNew.text == "") {

            ndvRouteOutlet.isUserInteractionEnabled = false
            ndvAgeTextField.isUserInteractionEnabled = false

        } else {
            ndvAgeTextField.isUserInteractionEnabled = true

        }

        if (ndvNew2.text == " " || ndvNew2.text == "") {
            ndv2RouteBtnOutlet.isUserInteractionEnabled = false
            ndv2AgeTextField.isUserInteractionEnabled = false
        } else {
            ndv2AgeTextField.isUserInteractionEnabled = true

        }

        if (otherStrain.text == " " || otherStrain.text == "") {
            otherRouteOutlet.isUserInteractionEnabled = false
            otherAgeTextField.isUserInteractionEnabled = false
        } else {
            otherAgeTextField.isUserInteractionEnabled = true

        }
    }
    @IBAction func tapOnFieldVaccination(_ sender: AnyObject) {
        mainView.endEditing(true)
        fieldVaccinationView.endEditing(true)
    }

    @IBAction func tapOnView(_ sender: AnyObject) {

        //  fieldVaccinationView.endEditing(true)
        innerView.endEditing(true)
        mainView.endEditing(true)

        hideDropDown()        // DropDown.sharedInstance.closeDropperDropDown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func DropperSelectedRow(_ path: IndexPath, contents: String) {

        markLabel.text = contents

    }

    /****************************** All Button Action ****************************************/

    @IBAction func bckBtn(_ sender: AnyObject) {

        btntag = 1
        allSaveData(btntag)
        //self.navigationController?.popViewControllerAnimated(true)

    }

    @IBAction func hatcheryButton(_ sender: AnyObject) {
        btnTag = 0

        hatcheryBtnOutlet.setImage(UIImage(named: "hatchery_selected_btn"), for: UIControl.State())
        fieldVaccinationBtnOutlet.setImage(UIImage(named: "field_vaccination_unselect_btn"), for: UIControl.State())

        fieldVaccinationView.isHidden = true

        innerView.isHidden = false

    }

    @IBAction func fieldVaccination(_ sender: AnyObject) {
        btnTag = 1
        hatcheryBtnOutlet.setImage(UIImage(named: "hatchery_unselected_btn"), for: UIControl.State())
        fieldVaccinationBtnOutlet.setImage(UIImage(named: "field_vaccination_select_btn"), for: UIControl.State())
        innerView.isHidden = true
        fieldVaccinationView.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {

        lngId = UserDefaults.standard.integer(forKey: "lngId")

        if finalizeValue == 1 {

            doneBTNoutlet.isHidden = true
            innerView.isUserInteractionEnabled = false
            fieldVaccinationView.isUserInteractionEnabled = false
            coccidiosisControl.isUserInteractionEnabled = false

        } else {
            doneBTNoutlet.isHidden = false
            innerView.isUserInteractionEnabled = true
            fieldVaccinationView.isUserInteractionEnabled = true
            coccidiosisControl.isUserInteractionEnabled = true

        }

        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String

        spacingTextField()

    }

    @IBAction func doneBttn(_ sender: AnyObject) {
        btntag = 2

        allSaveData(btntag)

    }

    func allSaveData( _ btnTag: Int) {
        var trimmedString = coccidiosisControl.text!.trimmingCharacters(in: .whitespaces)
        trimmedString = trimmedString.replacingOccurrences(of: ".", with: "", options:
            NSString.CompareOptions.literal, range: nil)
        coccidiosisControl.text = trimmedString
        if trimmedString == ""{
            if btnTag == 1 {

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.isDoneClick = true

                self.navigationController?.popViewController(animated: true)

            } else {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please enter the vaccination program.", comment: ""))
            }
        } else {
            ///////////Field vaccin///////

            if isClickOnAnyField == true {
                isClickOnAnyField = false

                for i in 0..<10 {

                    if i == 0 {

                        CoreDataHandler().saveFieldVacinationInDatabase(typeMarek.text!, strain: marekStrainTextField.text!, route: markLabel.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 1 {

                        CoreDataHandler().saveFieldVacinationInDatabase(typeIbdv.text!, strain: ibdvStrainTextField.text!, route: ibdvLabel.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 2 {

                        CoreDataHandler().saveFieldVacinationInDatabase(lblIbvTitle.text!, strain: ibvStrainTextField.text!, route: ibvRouteTextField.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)                //

                    } else if i == 3 {

                        CoreDataHandler().saveFieldVacinationInDatabase(typeTrt.text!, strain: trtStrainTextField.text!, route: trtLabel.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)                //

                    } else if i == 4 {

                        CoreDataHandler().saveFieldVacinationInDatabase(typeNdv.text!, strain: ndvStrainTextField.text!, route: ndvLabel.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 5 {

                        CoreDataHandler().saveFieldVacinationInDatabase(typePox.text!, strain: poxStrainTextField.text!, route: poxLbL.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 6 {

                        CoreDataHandler().saveFieldVacinationInDatabase(typeReo.text!, strain: reoStrainTextField.text!, route: reoLabel.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 7 {

                        CoreDataHandler().saveFieldVacinationInDatabase(stLabel.text!, strain: stHatcheryaStrainTextField.text!, route: hatcheryStRouteLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 8 {
                        CoreDataHandler().saveFieldVacinationInDatabase(ecoliLbl.text!, strain: eColiHatcheryStrainText.text!, route: HatcheryEcoliRouteLbl.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 9 {

                        CoreDataHandler().saveFieldVacinationInDatabase(typeOthers.text!, strain: othersStrainTextField.text!, route: othesLabel.text!, index: i, dbArray: fieldVaccinatioDataAray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    }

                }
                for i in 0..<11 {

                    if i == 0 {

                        CoreDataHandler().saveHatcheryVacinationInDatabase(type0.text!, strain: ibdvTextFieldNew.text!, route: routeLabel1.text!, age: ibdvAgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 1 {
                        CoreDataHandler().saveHatcheryVacinationInDatabase(type1.text!, strain: ibdv2StrainFieldTextField.text!, route: routeLabel2.text!, age: ibdv2AgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 2 {

                        CoreDataHandler().saveHatcheryVacinationInDatabase(type2.text!, strain: ibvStrainFieldTextField.text!, route: routeLabel3.text!, age: ibvAgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 3 {

                        CoreDataHandler().saveHatcheryVacinationInDatabase(type3.text!, strain: ibv2StrainFieldTextField.text!, route: routeLabel4.text!, age: ibv2AgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 4 {

                        CoreDataHandler().saveHatcheryVacinationInDatabase(type4.text!, strain: TrtFieldNew.text!, route: routeLabel5.text!, age: trtAgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 5 {

                        CoreDataHandler().saveHatcheryVacinationInDatabase(type5.text!, strain: trt2StrainFieldTextField.text!, route: routeLabel6.text!, age: trt2AgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 6 {
                        CoreDataHandler().saveHatcheryVacinationInDatabase(type6.text!, strain: ndvNew.text!, route: routeLabel7.text!, age: ndvAgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 7 {
                        CoreDataHandler().saveHatcheryVacinationInDatabase(lblNdvnew2Title.text!, strain: ndvNew2.text!, route: ndv2DisplayLabel.text!, age: ndv2AgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 8 {
                        CoreDataHandler().saveHatcheryVacinationInDatabase(stFieldVaccinationLbl.text!, strain: stStrainTextField.text!, route: stRouteFieldDisplayLbl.text!, age: stAgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)

                    } else if i == 9 {

                        CoreDataHandler().saveHatcheryVacinationInDatabase(ecoliFieldLbl.text!, strain: eColiStrainTextField.text!, route: eColiRouteFieldDisplayLbl.text!, age: ecoliAgeTEXTfield.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    } else if i == 10 {

                        CoreDataHandler().saveHatcheryVacinationInDatabase(lblOthersTitle.text!, strain: otherStrain.text!, route: otherDisplayLabel.text!, age: otherAgeTextField.text!, index: i, dbArray: dataArray, postingId: postingId, vaciProgram: coccidiosisControl.text!, sessionId: 1, isSync: true, lngId: lngId as NSNumber)
                    }
                }

                CoreDataHandler().updateisSyncTrueOnPostingSession(postingId)

                UserDefaults.standard.set(coccidiosisControl.text!, forKey: "vaci")
                UserDefaults.standard.synchronize()
            }

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.isDoneClick = true

            self.navigationController?.popViewController(animated: true)
        }
        appDelegate.sendFeedVariable = "vaccination"

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    func animateView (_ movement: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        })
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        Dropper.sharedInstance.hideWithAnimation(0.1)

        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        Dropper.sharedInstance.hideWithAnimation(0.1)

        if (textField == ndvNew ) {
            ndvNew.returnKeyType = UIReturnKeyType.done
        } else {
            ibvStrainTextField.returnKeyType = UIReturnKeyType.done
            trtStrainTextField.returnKeyType = UIReturnKeyType.done
            ndvStrainTextField.returnKeyType = UIReturnKeyType.done
            ibdvTextFieldNew.returnKeyType = UIReturnKeyType.done
            ibv2StrainFieldTextField.returnKeyType = UIReturnKeyType.done
            ibdvStrainTextField.returnKeyType = UIReturnKeyType.done
            ibdv2StrainFieldTextField.returnKeyType = UIReturnKeyType.done
            ibvStrainFieldTextField.returnKeyType = UIReturnKeyType.done
            ibv2StrainFieldTextField.returnKeyType = UIReturnKeyType.done
            trtStrainTextField.returnKeyType = UIReturnKeyType.done
            trt2StrainFieldTextField.returnKeyType = UIReturnKeyType.done
            ndvStrainTextField.returnKeyType = UIReturnKeyType.done
            ibdvAgeTextField.returnKeyType = UIReturnKeyType.done
            ibdv2AgeTextField.returnKeyType = UIReturnKeyType.done
            ibvAgeTextField.returnKeyType = UIReturnKeyType.done
            ibv2AgeTextField.returnKeyType = UIReturnKeyType.done
            trtAgeTextField.returnKeyType = UIReturnKeyType.done
            trt2AgeTextField.returnKeyType = UIReturnKeyType.done
            ndvAgeTextField.returnKeyType = UIReturnKeyType.done
            marekStrainTextField.returnKeyType = UIReturnKeyType.done
            ibdvStrainTextField.returnKeyType = UIReturnKeyType.done
            trtStrainTextField.returnKeyType = UIReturnKeyType.done
            ndvStrainTextField.returnKeyType = UIReturnKeyType.done
            poxStrainTextField.returnKeyType = UIReturnKeyType.done
            reoStrainTextField.returnKeyType = UIReturnKeyType.done
            othersStrainTextField.returnKeyType = UIReturnKeyType.done
            coccidiosisControl.returnKeyType = UIReturnKeyType.done
            TrtFieldNew.returnKeyType = UIReturnKeyType.done
            trt2StrainFieldTextField.returnKeyType = UIReturnKeyType.done
            ndvNew2.returnKeyType = UIReturnKeyType.done
            otherStrain.returnKeyType = UIReturnKeyType.done
            ndv2AgeTextField.returnKeyType = UIReturnKeyType.done
            otherAgeTextField.returnKeyType = UIReturnKeyType.done
            ndvAgeTextField.returnKeyType = UIReturnKeyType.done
            ibdvAgeTextField.returnKeyType = UIReturnKeyType.done
            ibdv2AgeTextField.returnKeyType = UIReturnKeyType.done
            ibvAgeTextField.returnKeyType = UIReturnKeyType.done
            ndvStrainTextField.returnKeyType = UIReturnKeyType.done
            ecoliAgeTEXTfield.returnKeyType = UIReturnKeyType.done
            eColiStrainTextField.returnKeyType = UIReturnKeyType.done
            stHatcheryaStrainTextField.returnKeyType = UIReturnKeyType.done
            eColiHatcheryStrainText.returnKeyType = UIReturnKeyType.done
            stAgeTextField.returnKeyType = UIReturnKeyType.done
            stStrainTextField.returnKeyType = UIReturnKeyType.done

        }
    }
    func showExitAlertWith(msg: String, tag: Int) {

        exitPopUP = popUP.loadFromNibNamed("popUP") as? popUP
        exitPopUP.lblFedPrgram.text = msg
        exitPopUP.tag = tag
        exitPopUP.lblFedPrgram.textAlignment = .center
        exitPopUP.delegatenEW = self
        exitPopUP.center = self.view.center
        self.view.addSubview(exitPopUP)

    }
    func noPopUpPosting() {
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            // Update posting session
            CoreDataHandler().updatePostingSessionOndashBoard(self.postingId as NSNumber, vetanatrionName: "", veterinarianId: 0, captureNec: 2)
            CoreDataHandler().deletefieldVACDataWithPostingId(self.postingId as NSNumber)
            CoreDataHandler().deleteDataWithPostingIdHatchery(self.postingId as NSNumber)
        } else {
            CoreDataHandler().deleteDataWithPostingId(self.postingId as NSNumber)
            CoreDataHandler().deletefieldVACDataWithPostingId(self.postingId as NSNumber)
            CoreDataHandler().deleteDataWithPostingIdHatchery(self.postingId as NSNumber)
        }
        for dashboard in (self.navigationController?.viewControllers)! {
            if dashboard.isKind(of: DashViewController.self) {
                self.navigationController?.popToViewController(dashboard, animated: true)
            }
        }
    }

    func YesPopUpPosting() {

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()

        return true

    }

    var index = 10

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField.tag {

        case 11, 12, 13, 14, 15, 16, 17, 18, 19, 30, 31 :

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

    @IBAction func marekDrinkingWaterBttn(_ sender: AnyObject) {
        view.endEditing(true)

        if (marekStrainTextField.text == " " || marekStrainTextField.text == "") {

            marekDrinkingWaterBtnOutlet.isUserInteractionEnabled = false
        } else {

            showDropDown(sender as! UIButton, lblName: markLabel, array: addVaciArray )
            isClickOnAnyField = true
        }
    }

    @IBAction func ibvRouteTextFieldAction(_ sender: AnyObject) {
        view.endEditing(true)

        if ibvStrainTextField.text == " " || ibvStrainTextField.text == ""{
            ibvRouteTextFieldOutlet.isUserInteractionEnabled = false
        } else {
            ibvRouteTextFieldOutlet.isUserInteractionEnabled = true

            showDropDown(sender as! UIButton, lblName: ibvRouteTextField, array: addVaciArray )
            isClickOnAnyField = true
        }
    }

    @IBAction func ibdvDrinkingWaterBttn(_ sender: AnyObject) {

        view.endEditing(true)
        if (ibdvStrainTextField.text == " " || ibdvStrainTextField.text == "") {

            ibdvDrinkingWaterBtnnOutlet.isUserInteractionEnabled = false

        } else {

            showDropDown(sender as! UIButton, lblName: ibdvLabel, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func ibdDrinkingWaterBttn(_ sender: AnyObject) {
        view.endEditing(true)

        if (ibvStrainTextField.text == " " || ibvStrainTextField.text == "") {

            ibdvDrinkingWaterBtnnOutlet.isUserInteractionEnabled = false
        } else {
            showDropDown(sender as! UIButton, lblName: ibdLabel, array: addVaciArray   )
            isClickOnAnyField = true
        }
    }

    @IBAction func trtDrinkingWaterBttn(_ sender: AnyObject) {
        view.endEditing(true)
        if (trtStrainTextField.text == " " || trtStrainTextField.text == "") {
            trtDrinkingWaterBtn.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: trtLabel, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func ndvDrinkingWaterBttn(_ sender: AnyObject) {
        view.endEditing(true)

        if(ndvStrainTextField.text == " " || ndvStrainTextField.text == "") {
            ndvDrinkingWaterBtn.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: ndvLabel, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func poxDrinkingWaterBttn(_ sender: AnyObject) {
        view.endEditing(true)

        if ( poxStrainTextField.text == " " || poxStrainTextField.text == "") {
            poxDrinkingWaterbTN.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: poxLbL, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func reoDrinkingWaterBttn(_ sender: AnyObject) {
        view.endEditing(true)

        if(reoStrainTextField.text == " " || reoStrainTextField.text == "") {
            reoDrinkingWaterOutlet.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: reoLabel, array: addVaciArray  )
            isClickOnAnyField = true
        }

    }

    @IBAction func othersDrinkingWaterBttn(_ sender: AnyObject) {

        view.endEditing(true)

        if (othersStrainTextField.text == " " || othersStrainTextField.text == "") {

            othersDrinkingWaterBtn.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: othesLabel, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func ibdvRouteFieldBtnAction(_ sender: AnyObject) {
        view.endEditing(true)
        if (ibdvTextFieldNew.text == " " || ibdvTextFieldNew.text == "") {
            ibdvAgeTextField.isUserInteractionEnabled = false
            ibdvRouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: routeLabel1, array: addVaciArray  )
            isClickOnAnyField = true
        }}

    @IBAction func ibdv2RouteFieldBtnAction(_ sender: AnyObject) {
        view.endEditing(true)

        if (ibdv2StrainFieldTextField.text == " " || ibdv2StrainFieldTextField.text == "") {
            ibdv2AgeTextField.isUserInteractionEnabled = false
            ibdv2RouteOutlet.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: routeLabel2, array: addVaciArray )
            isClickOnAnyField = true
        }
    }
    @IBAction func ibvRouteFieldBtnAction(_ sender: AnyObject) {
        view.endEditing(true)

        if (ibvStrainFieldTextField.text == " " || ibvStrainFieldTextField.text == "") {

            ibvRouteFieldOutlet.isUserInteractionEnabled = false
            ibvAgeTextField.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: routeLabel3, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func ibv2RouteFieldBtnAction(_ sender: AnyObject) {
        view.endEditing(true)

        if (ibv2StrainFieldTextField.text == " " || ibv2StrainFieldTextField.text == "") {
            ibv2RouteOutlet.isUserInteractionEnabled = false
            ibv2AgeTextField.isUserInteractionEnabled = false

        } else {

            showDropDown(sender as! UIButton, lblName: routeLabel4, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func trtRouteFieldBtnAction(_ sender: AnyObject) {
        view.endEditing(true)
        if (TrtFieldNew.text == " " || TrtFieldNew.text == "") {

            trtRouteOutlet.isUserInteractionEnabled = false
            trtAgeTextField.isUserInteractionEnabled = false

        } else {

            showDropDown(sender as! UIButton, lblName: routeLabel5, array: addVaciArray  )
            isClickOnAnyField = true
        }}

    @IBAction func trt2RouteFieldBtnAction(_ sender: AnyObject) {
        view.endEditing(true)

        if (trt2StrainFieldTextField.text == " " || trt2StrainFieldTextField.text == "") {
            trt2AgeTextField.isUserInteractionEnabled = false
            trt2RouteFieldOutlet.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: routeLabel6, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func ndvRouteFieldBtnAction(_ sender: AnyObject) {
        view.endEditing(true)

        if (ndvNew.text == " " || ndvNew.text == "") {

            ndvRouteOutlet.isUserInteractionEnabled = false
            ndvAgeTextField.isUserInteractionEnabled = false

        } else {
            showDropDown(sender as! UIButton, lblName: routeLabel7, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }

    @IBAction func ndv2routeBtnAction(_ sender: AnyObject) {
        view.endEditing(true)
        if (ndvNew2.text == " " || ndvNew2.text == "") {
            ndv2RouteBtnOutlet.isUserInteractionEnabled = false
            ndv2AgeTextField.isUserInteractionEnabled = false
        } else {
            showDropDown(sender as! UIButton, lblName: ndv2DisplayLabel, array: addVaciArray  )
            isClickOnAnyField = true
        }
    }
    @IBOutlet weak var ndv2RouteBtnOutlet: UIButton!
    @IBAction func otherRouteBtnAction(_ sender: AnyObject) {
        view.endEditing(true)
        if (otherStrain.text == " " || otherStrain.text == "") {
            otherRouteOutlet.isUserInteractionEnabled = false
            otherAgeTextField.isUserInteractionEnabled = false
        } else {
            showDropDown(sender as! UIButton, lblName: otherDisplayLabel, array: addVaciArray  )

            isClickOnAnyField = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        if (otherStrain.text?.isEmpty == false ) {
            otherRouteOutlet.isUserInteractionEnabled = true
            otherAgeTextField.isUserInteractionEnabled = true

            isClickOnAnyField = true
        }
        if (ndvNew2.text?.isEmpty == false ) {
            ndv2RouteBtnOutlet.isUserInteractionEnabled = true
            ndv2AgeTextField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ndvNew.text?.isEmpty == false ) {
            ndvRouteOutlet.isUserInteractionEnabled = true
            ndvAgeTextField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (trt2StrainFieldTextField.text?.isEmpty == false ) {
            trt2AgeTextField.isUserInteractionEnabled = true
            trt2RouteFieldOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (TrtFieldNew.text?.isEmpty == false ) {
            trtRouteOutlet.isUserInteractionEnabled = true
            trtAgeTextField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ibv2StrainFieldTextField.text?.isEmpty == false ) {
            ibv2RouteOutlet.isUserInteractionEnabled = true
            ibv2AgeTextField.isUserInteractionEnabled = true
            isClickOnAnyField = true

        }
        if (ibdv2StrainFieldTextField.text?.isEmpty == false ) {
            ibdv2AgeTextField.isUserInteractionEnabled = true
            ibdv2RouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true

        }
        if (ibvStrainFieldTextField.text?.isEmpty == false ) {
            ibvRouteFieldOutlet.isUserInteractionEnabled = true
            ibvAgeTextField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ibdvTextFieldNew.text?.isEmpty == false ) {
            ibdvAgeTextField.isUserInteractionEnabled = true
            ibdvRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (othersStrainTextField.text?.isEmpty == false ) {
            othersDrinkingWaterBtn.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (reoStrainTextField.text?.isEmpty == false ) {
            reoDrinkingWaterOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (poxStrainTextField.text?.isEmpty == false ) {
            poxDrinkingWaterbTN.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ndvStrainTextField.text?.isEmpty == false ) {
            ndvDrinkingWaterBtn.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (trtStrainTextField.text?.isEmpty == false ) {
            trtDrinkingWaterBtn.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ibvStrainTextField.text?.isEmpty == false ) {
            ibdvDrinkingWaterBtnnOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ibvStrainTextField.text?.isEmpty == false ) {
            ibdvDrinkingWaterBtnnOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (marekStrainTextField.text?.isEmpty == false ) {
            marekDrinkingWaterBtnOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (ibvStrainTextField.text?.isEmpty == false ) {
            ibvRouteTextFieldOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (stHatcheryaStrainTextField.text?.isEmpty == false ) {
            hatcheryStRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (eColiHatcheryStrainText.text?.isEmpty == false ) {
            hatcheryEcoliRouteOutlet.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (stStrainTextField.text?.isEmpty == false ) {
            stRouteOutlet.isUserInteractionEnabled = true
            stAgeTextField.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }
        if (eColiStrainTextField.text?.isEmpty == false ) {
            ecolibtnOutlet.isUserInteractionEnabled = true
            ecoliAgeTEXTfield.isUserInteractionEnabled = true
            isClickOnAnyField = true
        }

    }

    func spacingTextField() {

        let cusPaddingView190 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibvAgeTextField.leftView = cusPaddingView190
        ibvAgeTextField.leftViewMode = .always

        let cusPaddingView15 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ndvNew.leftView = cusPaddingView15
        ndvNew.leftViewMode = .always
        let cusPaddingView16 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        TrtFieldNew.leftView = cusPaddingView16
        TrtFieldNew.leftViewMode = .always
        let cusPaddingView17 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibdvTextFieldNew.leftView = cusPaddingView17
        ibdvTextFieldNew.leftViewMode = .always
        let cusPaddingView18 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        othersStrainTextField.leftView = cusPaddingView18
        othersStrainTextField.leftViewMode = .always
        let cusPaddingView19 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        reoStrainTextField.leftView = cusPaddingView19
        reoStrainTextField.leftViewMode = .always
        let cusPaddingView20 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        poxStrainTextField.leftView = cusPaddingView20
        poxStrainTextField.leftViewMode = .always
        let cusPaddingView21 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ndvStrainTextField.leftView = cusPaddingView21
        ndvStrainTextField.leftViewMode = .always
        let cusPaddingView22 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        trtStrainTextField.leftView = cusPaddingView22
        trtStrainTextField.leftViewMode = .always
        //        let cusPaddingView23 = UIView(frame: CGRectMake(15, 0, 10, 20))
        //        ibdStrainTextField.leftView = cusPaddingView23
        //        ibdStrainTextField.leftViewMode = .Always
        let cusPaddingView24 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibdvStrainTextField.leftView = cusPaddingView24
        ibdvStrainTextField.leftViewMode = .always

        /////
        let cusPaddingView25 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        marekStrainTextField.leftView = cusPaddingView25
        marekStrainTextField.leftViewMode = .always
        let cusPaddingView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ndvAgeTextField.leftView = cusPaddingView
        ndvAgeTextField.leftViewMode = .always
        let cusPaddingView1 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        trt2AgeTextField.leftView = cusPaddingView1
        trt2AgeTextField.leftViewMode = .always
        let cusPaddingView2 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        trtAgeTextField.leftView = cusPaddingView2
        trtAgeTextField.leftViewMode = .always
        let cusPaddingView3 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibv2AgeTextField.leftView = cusPaddingView3
        ibv2AgeTextField.leftViewMode = .always
        let cusPaddingView4 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibdvAgeTextField.leftView = cusPaddingView4
        ibdvAgeTextField.leftViewMode = .always
        let cusPaddingView5 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibdv2AgeTextField.leftView = cusPaddingView5
        ibdv2AgeTextField.leftViewMode = .always
        let cusPaddingView6 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibdvAgeTextField.leftView = cusPaddingView6
        ibdvAgeTextField.leftViewMode = .always
        let cusPaddingView7 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        coccidiosisControl.leftView = cusPaddingView7
        coccidiosisControl.leftViewMode = .always
        //        let cusPaddingView8 = UIView(frame: CGRectMake(15, 0, 10, 20))
        //        ndvStrainFieldTextField.leftView = cusPaddingView8
        //        ndvStrainFieldTextField.leftViewMode = .Always
        let cusPaddingView9 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        trt2StrainFieldTextField.leftView = cusPaddingView9
        trt2StrainFieldTextField.leftViewMode = .always
        //        let cusPaddingView10 = UIView(frame: CGRectMake(15, 0, 10, 20))
        //        trtStrainFieldTextField.leftView = cusPaddingView10
        //        trtStrainFieldTextField.leftViewMode = .Always
        let cusPaddingView11 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibv2StrainFieldTextField.leftView = cusPaddingView11
        ibv2StrainFieldTextField.leftViewMode = .always
        let cusPaddingView12 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibvStrainFieldTextField.leftView = cusPaddingView12
        ibvStrainFieldTextField.leftViewMode = .always
        let cusPaddingView13 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibdv2StrainFieldTextField.leftView = cusPaddingView13
        ibdv2StrainFieldTextField.leftViewMode = .always
        //        let cusPaddingView14 = UIView(frame: CGRectMake(15, 0, 10, 20))
        //        ibdvStrainFieldTextField.leftView = cusPaddingView14
        //        ibdvStrainFieldTextField.leftViewMode = .Always

        let cusPaddingView26 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ibvStrainTextField.leftView = cusPaddingView26
        ibvStrainTextField.leftViewMode = .always

        let cusPaddingView27 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        otherAgeTextField.leftView = cusPaddingView27
        otherAgeTextField.leftViewMode = .always

        let cusPaddingView28 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ndv2AgeTextField.leftView = cusPaddingView28
        ndv2AgeTextField.leftViewMode = .always

        let cusPaddingView29 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        otherStrain.leftView = cusPaddingView29
        otherStrain.leftViewMode = .always

        let cusPaddingView30 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ndvNew2.leftView = cusPaddingView30
        ndvNew2.leftViewMode = .always

        let cusPaddingView31 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        stAgeTextField.leftView = cusPaddingView31
        stAgeTextField.leftViewMode = .always

        let cusPaddingView32 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        stStrainTextField.leftView = cusPaddingView32
        stStrainTextField.leftViewMode = .always

        let cusPaddingView33 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        ecoliAgeTEXTfield.leftView = cusPaddingView33
        ecoliAgeTEXTfield.leftViewMode = .always

        let cusPaddingView34 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        eColiStrainTextField.leftView = cusPaddingView34
        eColiStrainTextField.leftViewMode = .always

        let cusPaddingView35 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        stHatcheryaStrainTextField.leftView = cusPaddingView35
        stHatcheryaStrainTextField.leftViewMode = .always
        let cusPaddingView36 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        eColiHatcheryStrainText.leftView = cusPaddingView36
        eColiHatcheryStrainText.leftViewMode = .always

    }

    @IBOutlet weak var stRouteOutlet: UIButton!
    @IBAction func stRouteBtn(_ sender: AnyObject) {
        view.endEditing(true)
        if (stStrainTextField.text == " " || stStrainTextField.text == "") {
            stRouteOutlet.isUserInteractionEnabled = false
            stAgeTextField.isUserInteractionEnabled = false
        } else {
            showDropDown(sender as! UIButton, lblName: stRouteFieldDisplayLbl, array: addVaciArray  )
            isClickOnAnyField = true
        }

    }
    @IBOutlet weak var ecolibtnOutlet: UIButton!
    @IBAction func eColiBtn(_ sender: AnyObject) {
        view.endEditing(true)
        if (eColiStrainTextField.text == " " || eColiStrainTextField.text == "") {
            ecolibtnOutlet.isUserInteractionEnabled = false
            ecoliAgeTEXTfield.isUserInteractionEnabled = false
        } else {
            showDropDown(sender as! UIButton, lblName: eColiRouteFieldDisplayLbl, array: addVaciArray  )
            isClickOnAnyField = true
        }

    }

    @IBOutlet weak var ecoliAgeTEXTfield: UITextField!
    @IBOutlet weak var eColiStrainTextField: UITextField!
    @IBOutlet weak var stHatcheryaStrainTextField: UITextField!
    @IBOutlet weak var eColiHatcheryStrainText: UITextField!
    @IBOutlet weak var stAgeTextField: UITextField!
    @IBOutlet weak var stStrainTextField: UITextField!

    @IBOutlet weak var hatcheryStRouteLbl: UILabel!
    @IBAction func hatcheryStRouteBtn(_ sender: AnyObject) {

        view.endEditing(true)

        if (stHatcheryaStrainTextField.text == " " || stHatcheryaStrainTextField.text == "") {

            hatcheryStRouteOutlet.isUserInteractionEnabled = false
        } else {

            showDropDown(sender as! UIButton, lblName: hatcheryStRouteLbl, array: addVaciArray )
            isClickOnAnyField = true
        }
    }

    @IBAction func hatcheryEcoliRouteBtn(_ sender: AnyObject) {

        view.endEditing(true)

        if (eColiHatcheryStrainText.text == " " || eColiHatcheryStrainText.text == "") {

            hatcheryEcoliRouteOutlet.isUserInteractionEnabled = false
        } else {

            showDropDown(sender as! UIButton, lblName: HatcheryEcoliRouteLbl, array: addVaciArray )
            isClickOnAnyField = true
        }

    }
}
