//
//  notes.swift
//  Zoetis -Feathers
//
//  Created by "" on 22/11/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit
protocol openNotes: class {
    func openNoteFunc ()
    func doneBtnFunc (_ notes: NSMutableArray, notesText: String, noOfBird: Int)

    func postingNotesdoneBtnFunc(_ notesText: String)
}

class notes: UIView, UITextViewDelegate {

    var noteDelegate: openNotes!

    var noOfBird: Int!
    var necId: Int!
    var strExist: String!
    var necIdFromExisting: Int!
    var finalizeValue: Int!
    var notesDict: NSMutableArray!
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Notes", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var doneButtobn: UIButton!
    @IBOutlet weak var mainViewBck: UIView!
    override func draw(_ rect: CGRect) {

        if finalizeValue == 1 {
            doneButtobn.alpha = 0
           // textViewN.userInteractionEnabled = false
            textViewN.isEditable = false
        } else {

           // textViewN.userInteractionEnabled = true
            textViewN.isEditable = true

            doneButtobn.alpha = 1
        }

        if notesDict.count > 0 {

            let skleta: CaptureNecropsyViewData = notesDict.object(at: 0) as! CaptureNecropsyViewData

            let formName = skleta.formName
            let catName  = skleta.catName

            if strExist == "Exting"{
                 necId = necIdFromExisting

            } else {
                   necId = UserDefaults.standard.integer(forKey: "necId") as Int
            }

            let isNotes = CoreDataHandler().fetchNoofBirdWithNotes(catName!, formName: formName!, birdNo: noOfBird as NSNumber, necId: necId as NSNumber)
            if isNotes.count > 0 {
                let note: NotesBird = isNotes[0] as! NotesBird
                textViewN.text =  note.notes
            }

        } else {

            let str =  UserDefaults.standard.value(forKey: "postingSessionNotes") as! String
            if str.isEmpty {

            } else {
                textViewN.text = str
            }

        }

        textViewN.layer.borderColor = UIColor.gray.cgColor
        textViewN.layer.borderWidth = 1.0

    mainViewBck.layer.borderWidth = 1.0
    mainViewBck.layer.cornerRadius = 8
    }

    @IBOutlet weak var textViewN: UITextView!

    @IBAction func doneBttn(_ sender: AnyObject) {

        if finalizeValue == 1 {

        } else {

            noteDelegate.doneBtnFunc(self.notesDict, notesText: textViewN.text, noOfBird: noOfBird)
            noteDelegate.postingNotesdoneBtnFunc(textViewN.text)

        }

    }
    func textViewShouldReturn(_ textView: UITextView) {

        textViewN.resignFirstResponder()

    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n\n") {
            textViewN.resignFirstResponder()
            return false
        }
        return true
    }

    @IBAction func cancelBttn(_ sender: AnyObject) {

        noteDelegate.openNoteFunc()

       }
    func postAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))

        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
