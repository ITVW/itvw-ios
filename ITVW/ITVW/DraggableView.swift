//
//  DraggableView.swift
//  ITVW
//
//  Created by Rachel Schifano on 5/12/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

// Distance from center where action applies.
// Higher = swipe further for the action to be called
let ACTION_MARGIN: Float = 120
// How quickly the card shrinks.
// Higher = slower shrinking
let SCALE_STRENGTH: Float = 4
// Upper bar for how much the card shrinks
// Higher = shrinks less
let SCALE_MAX: Float = 0.93
// The maximum rotation allowed in radians.
// Higher = card can keep rotating
let ROTATION_MAX: Float = 1
// Strength of rotation.
// Higher = weaker rotation
let ROTATION_STRENGTH: Float = 320
// Higher = stronger rotation angle (0.3925) ?
let ROTATION_ANGLE: Float = 3.14/8

protocol DraggableViewDelegate {
    func cardSwipedLeft(card: UIView) -> Void
    func cardSwipedRight(card: UIView) -> Void
}

class DraggableView: UIView {
    var delegate: DraggableViewDelegate!
    var pangestureRecognizer: UIPanGestureRecognizer!
    var originPoint: CGPoint!
    var xFromCenter: Float!
    var yFromCenter: Float!
    
//    var information: UILabel!
//    var overlayView: OverlayView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        
    }
    
    func setupView() -> Void {
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSizeMake(1,1)
    }
    
    
}











