//
//  PVEFinalizeAsseementCell.swift
//  Zoetis -Feathers
//
//  Created by Nitin kumar Kanojia on 23/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

protocol CategorySelectionDelegate {
    func selectedAssessmentId(selectedId: Int, selectedArr:[[String : AnyObject]])
}

class PVEFinalizeAsseementCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let dropdownManager = ZoetisDropdownShared.sharedInstance
    var delegate: CategorySelectionDelegate? = nil
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
    }

    func selectFirstTab() {
        let id = dropdownManager.sharedAssCategoriesDetailsResPVE?[0].id
        let quesArr = dropdownManager.sharedAssCategoriesDetailsResPVE?[0].assessmentQuestion
        delegate?.selectedAssessmentId(selectedId:id!, selectedArr: quesArr!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dropdownManager.sharedAssCategoriesDetailsResPVE!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath as IndexPath) as! CollectionViewCell
        cell.categoryName.text = dropdownManager.sharedAssCategoriesDetailsResArrPVE?[indexPath.row] ?? ""
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 200, height: 70)
       }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAtIndex section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: -10,left: 0, bottom: 10,right: 0)
    }
    //extension ViewController: UICollectionViewDelegateFlowLayout {
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: 150, height: 100)
    //    }
    //}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.cellForItem(at: indexPath) as? CollectionViewCell) != nil {

            let id = dropdownManager.sharedAssCategoriesDetailsResPVE?[indexPath.row].id
            let quesArr = dropdownManager.sharedAssCategoriesDetailsResPVE?[indexPath.row].assessmentQuestion
            delegate?.selectedAssessmentId(selectedId:id!, selectedArr: quesArr!)
        }
    }
}

