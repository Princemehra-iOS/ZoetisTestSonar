//
//  Constants.swift
//
//  Created by "" ""on 21/11/18.
//  Copyright © "" Kumar Panday. All rights reserved.
//




import UIKit

internal struct DPDConstant {
	
	internal struct KeyPath {
		
		static let Frame = "frame"
		
	}
	
	internal struct ReusableIdentifier {
		
		static let DropDownCell = "DropDownCell"
		
	}
	
	internal struct UI {
		
        static let BackgroundColor = UIColor.white
		static let SelectionBackgroundColor = UIColor(white: 0.89, alpha: 1)
		static let SeparatorColor = UIColor.clear
        static let SeparatorStyle = UITableViewCell.SeparatorStyle.none
		static let SeparatorInsets = UIEdgeInsets.zero
		static let CornerRadius: CGFloat = 2
		static let RowHeight: CGFloat = 44
		static let HeightPadding: CGFloat = 20
		
		struct Shadow {
			
			static let Color = UIColor.getTextViewBorderColorStartAssessment().cgColor
			static let Offset = CGSize.zero
			static let Opacity: Float = 0.4
			static let Radius: CGFloat = 8
			
		}
		
	}
	
	internal struct Animation {
		
		static let Duration = 0.15
        static let EntranceOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseOut]
        static let ExitOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseIn]
		static let DownScaleTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
		
	}
	
}
