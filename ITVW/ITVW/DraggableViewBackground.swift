//
//  DraggableViewBackground.swift
//  ITVW
//
//  Created by Rachel Schifano on 5/12/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

class DraggableViewBackground: UIView, DraggableViewDelegate {
    
    // Card constants
    let CARD_HEIGHT: CGFloat = 386
    let CARD_WIDTH: CGFloat = 390
    
    // Buttons
    var xButton: UIButton!
    var checkButton: UIButton!
    
    // Card Info
    var exampleCardLabels: [String]!
    var allCards: [DraggableView]!
    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    let MAX_BUFFER_SIZE = 2
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        setupViews()
    }
    
    func setupViews() -> Void {
        self.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1)
        
        // Create the x button and apply the swipeLeft action
        xButton = UIButton(frame: CGRectMake((self.frame.size.width - CARD_WIDTH)/2 + 35, self.frame.size.height/2 + CARD_HEIGHT/2 + 10, 59, 59))
        xButton.setImage(UIImage(named: "xButton"), forState: UIControlState.Normal)
        xButton.addTarget(self, action: #selector(DraggableViewBackground.swipeLeft), forControlEvents: UIControlEvents.TouchUpInside)
        // Create the check button and apply the swipeRight action
        checkButton = UIButton(frame: CGRectMake(self.frame.size.width/2 + CARD_WIDTH/2 - 85, self.frame.size.height/2 + CARD_HEIGHT/2 + 10, 59, 59))
        checkButton.setImage(UIImage(named: "checkButton"), forState: UIControlState.Normal)
        checkButton.addTarget(self, action: #selector(DraggableViewBackground.swipeRight), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Add button subviews to current view
        addSubview(xButton)
        addSubview(checkButton)
    }
    
    // MARK: Load cards
    
    
    
    // MARK: DraggableViewDelegate methods
    func cardSwipedLeft(card: UIView) {
        
    }
    
    func cardSwipedRight(card: UIView) {
        
    }
    
    func swipeLeft() -> Void {
        
    }
    
    func swipeRight() -> Void {
        
    }
}