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
    var vaporwaveImages: [[String: AnyObject]]!
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
        
        // Load vaporwave image data
        vaporwaveImages = hardCodedVaporwaveData()
        
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
//        self.loadCards()
    }
    
    // TODO: Probably want to use Storyboard later
    func setupViews() -> Void {
        // Set view background color to a gray
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
//    func loadCards() -> Void {
//        if vaporwaveImages.count > 0 {
//            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : vaporwaveImages.count
//            for var i = 0; i < exampleCardLabels.count; i++ {
//                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
//                allCards.append(newCard)
//                if i < numLoadedCardsCap {
//                    loadedCards.append(newCard)
//                }
//            }
//            
//            for var i = 0; i < loadedCards.count; i++ {
//                if i > 0 {
//                    self.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
//                } else {
//                    self.addSubview(loadedCards[i])
//                }
//                cardsLoadedIndex = cardsLoadedIndex + 1
//            }
//        }
//    }
    
    
    // MARK: DraggableViewDelegate methods
    func cardSwipedLeft(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
    
    func cardSwipedRight(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
    
    
    func swipeLeft() -> Void {
        
    }
    
    func swipeRight() -> Void {
        
    }
    
    // MARK: Vaporwave data
    func hardCodedVaporwaveData() ->[[String: AnyObject]] {
        return [
            [
                "image": "vw1",
            ], [
                "image": "vw2",
            ], [
                "image": "vw3",
            ], [
                "image": "vw4",
            ], [
                "image": "vw5",
            ], [
                "image": "vw6",
            ]
        ]
    }

}