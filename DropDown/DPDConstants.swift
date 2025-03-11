//
//  Constants.swift
//
//  Created by "" ""on 21/11/18.
//  Copyright © "" Kumar Panday. All rights reserved.
//




import UIKit

internal struct DPDConstant {
	
	internal struct KeyPath {
		
		static let frame = "frame"
		
	}
	
	
	
    internal struct ReusableIdentifier {
        
        static let dropDownCell = "DropDownCell"
        
    }
    
    internal struct UI {
        
        static let backgroundColor = UIColor.white
        static let selectionBackgroundColor = UIColor(white: 0.89, alpha: 1)
        static let separatorColor = UIColor.clear
        static let separatorStyle = UITableViewCell.SeparatorStyle.none
        static let separatorInsets = UIEdgeInsets.zero
        static let cornerRadius: CGFloat = 2
        static let rowHeight: CGFloat = 44
        static let heightPadding: CGFloat = 20
        
        struct Shadow {
            
            static let color = UIColor.getTextViewBorderColorStartAssessment().cgColor
            static let offset = CGSize.zero
            static let opacity: Float = 0.4
            static let radius: CGFloat = 8
            
        }
        
    }
    
    internal struct Animation {
        
        static let duration = 0.15
        static let entranceOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseOut]
        static let exitOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseIn]
        static let downScaleTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
    }
    
	
}
