//
//  InfoViewController.swift
//  Zoetis -Feathers
//
//  Created by "" on 12/2/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 5
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CaptureNecropsyCollectionViewCell
        let image = UIImage(named: "Image02")
        cell.infoImage.image = image
        // cell.infoLabel.text =  "Data"

        return cell
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
