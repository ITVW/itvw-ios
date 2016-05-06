//
//  VWCollectionViewFlowLayout.swift
//  ITVW
//
//  Created by Rachel Schifano on 5/4/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

class VWCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = CGFloat.max
        let horizontalOffset = proposedContentOffset.x
        let targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView!.bounds.size.width, self.collectionView!.bounds.size.height)
        
        for layoutAttributes in super.layoutAttributesForElementsInRect(targetRect)! {
            let itemOffset = layoutAttributes.frame.origin.x
            if (abs(itemOffset - horizontalOffset) < abs(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }
        return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y)
    }
}