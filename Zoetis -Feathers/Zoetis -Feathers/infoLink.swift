//
//  infoLinkPopUp.swift
//  Zoetis -Feathers
//
//  Created by "" on 18/10/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit

protocol closeButton {
    func noPopUpPosting()

}

class infoLink: UIView {

    var delegateInfo: closeButton!

    @IBOutlet weak var backBtnA: UIButton!

    @IBAction func doneButtAction(_ sender: AnyObject) {

        //   delegateInfo.doneButton()
        // self.removeFromSuperview()

    }

    func removeView(_ view1: UIView) -> UIView {
        let transitionOptions = UIView.AnimationOptions.transitionCurlUp
        UIView.transition(with: self, duration: 0.75, options: transitionOptions, animations: {
            self.alpha = 0

        }, completion: { _ in
            self.removeFromSuperview()
            // any code entered here will be applied
            // .once the animation has completed
        })

        return self
    }

    @IBAction func noButtonAction(_ sender: AnyObject) {

        delegateInfo.noPopUpPosting()
        self.removeFromSuperview()

    }
    func showView(_ view1: UIView, frame1: CGRect) -> UIView {

        self.frame = frame1
        view1.addSubview(self)
        self.alpha = 0
        let transitionOptions = UIView.AnimationOptions.transitionCurlDown
        UIView.transition(with: self, duration: 0.75, options: transitionOptions, animations: {
            self.alpha = 1

        }, completion: { _ in

        })
        return self
    }

}
