//
//  VWCollectionViewController.swift
//  ITVW
//
//  Created by Rachel Schifano on 5/3/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

class VWCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout.itemSize = CGSizeMake(self.view.frame.width, self.view.frame.height)
        flowLayout.minimumLineSpacing = 0
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: Collection View Methods
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hardCodedData().count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VWCell", forIndexPath: indexPath) as! VWCollectionViewCell
        
        var vw = hardCodedData()[indexPath.row]

        let vwImageName = vw["image"] as! String
        let vwImage = UIImage.init(named: vwImageName)
        cell.vwImageViewCell.image = vwImage
        
        return cell
    }
    
    func hardCodedData() ->[[String: AnyObject]] {
        return [
            [
                "image": "vw1",
            ], [
                "image": "vw2",
            ]
        ]
    }

    
}
