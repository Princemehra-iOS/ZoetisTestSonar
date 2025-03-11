//
//  NotesTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 27/03/18.
//  Copyright © 2018 Alok Yadav. All rights reserved.
//

import UIKit

protocol turkeyNotes {
    func openNoteFunc ()
    func doneBtnFunc (_ notes: NSMutableArray, notesText: String, noOfBird: Int)
    func postingNotesdoneBtnFunc(_ notesText: String)
}

class NotesTurkey: UIView {

    var notesDelegate: turkeyNotes!

    @IBOutlet weak var mainViewBck: UIView!
    var noOfBird: Int!
    var necId: Int!
    var strExist: String!
    var necIdFromExisting: Int!
    var finalizeValue: Int!
    var notesDict: NSMutableArray!
    @IBOutlet weak var doneButtobn: UIButton!

    override func draw(_ rect: CGRect) {

        if finalizeValue == 1 {
            doneButtobn.alpha = 0
            textView.isEditable = false
        } else {

            textView.isEditable = true
            doneButtobn.alpha = 1
        }

        if notesDict.count > 0 {

            let skleta: CaptureNecropsyViewDataTurkey = notesDict.object(at: 0) as! CaptureNecropsyViewDataTurkey

            let formName = skleta.formName
            let catName  = skleta.catName

            if strExist == "Exting"{
                necId = necIdFromExisting

            } else {
                necId = UserDefaults.standard.integer(forKey: "necId") as Int
            }

            let isNotes = CoreDataHandlerTurkey().fetchNoofBirdWithNotesTurkey(catName!, formName: formName!, birdNo: noOfBird as NSNumber, necId: necId as NSNumber)
            if isNotes.count > 0 {
                let note: NotesBirdTurkey = isNotes[0] as! NotesBirdTurkey
                textView.text =  note.notes
            }

        } else {

            let str =  UserDefaults.standard.value(forKey: "postingSessionNotes") as! String
            if str.isEmpty {

            } else {
                textView.text = str
            }
        }

        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1.0

        mainViewBck.layer.borderWidth = 1.0
        mainViewBck.layer.cornerRadius = 8
    }
    @IBOutlet weak var textView: UITextView!

    @IBAction func doneBtnAction(_ sender: UIButton) {

        if finalizeValue == 1 {

        } else {

            notesDelegate.doneBtnFunc(self.notesDict, notesText: textView.text, noOfBird: noOfBird)
            notesDelegate.postingNotesdoneBtnFunc(textView.text)

        }
    }
    @IBAction func crossBtnAction(_ sender: UIButton) {

        notesDelegate.openNoteFunc()
    }

    func textViewShouldReturn(_ textView: UITextView) {

        textView.resignFirstResponder()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    @IBAction func cancelBttn(_ sender: AnyObject) {

        notesDelegate.openNoteFunc()
    }

    func postAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
