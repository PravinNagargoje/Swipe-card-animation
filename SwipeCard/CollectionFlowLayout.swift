//
//  CollectionFlowLayout.swift
//  SwipeCard
//
//  Created by Mac on 15/02/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class CollectionFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
        ) -> CGPoint {
        
        if let cv = self.collectionView {
            
            let collectionViewBounds = cv.bounds
            let halfWidth = collectionViewBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds) {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    if (attributes.center.x == 0) || (attributes.center.x > (cv.contentOffset.x + halfWidth) && velocity.x < 0) {
                        continue
                    }
                    
                    // First time in the loop
                    guard let candAttributes = candidateAttributes else {
                        candidateAttributes = attributes
                        continue
                    }
                    
                    let a = attributes.center.x - proposedContentOffsetCenterX
                    let b = candAttributes.center.x - proposedContentOffsetCenterX
                    
                    if fabsf(Float(a)) < fabsf(Float(b)) {
                        candidateAttributes = attributes
                    }
                }
                
//                if(proposedContentOffset.x == -(cv.contentInset.left)) {
//                    return proposedContentOffset
//                }
                var data: CGFloat = 0
                if let value = candidateAttributes?.center.x {
                    data = value
                }
                
                return CGPoint(x: floor(data - halfWidth), y: proposedContentOffset.y)
            }
        }
        
        // fallback
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
}
