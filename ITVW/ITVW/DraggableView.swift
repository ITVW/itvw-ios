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
let ROTATION_STRENGTH: Float = 320 // Also 320px is width of iPhone 4 (?)
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
        
        // TODO: Add information if necessary here
        
        // Create and hide the overlay
        // Create new pan gesture recognizer for swiping actions
        pangestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DraggableView.beingDragged(_:)))
        
        
    }
    
    /*
        Sets up the view to look like a generic card, including rounded corners, shadow radius.
    */
    func setupView() -> Void {
        self.layer.cornerRadius = 4 // The radius to use when drawing rounded corners for the layer's background
        self.layer.shadowRadius = 3 // The blur radius in points used to render the layer's shadow
        self.layer.shadowOpacity = 0.2 // The opacity of the layer's shadow
        self.layer.shadowOffset = CGSizeMake(1,1) // The offset in points of the layer's shadow (width, height)
        
        self.backgroundColor = UIColor.whiteColor() // FIXME: Does not need to be in init?
    }
    
    func beingDragged(gestureRecognizer: UIPanGestureRecognizer) -> Void {
        // Points identifying the new location of a view in the coord system of its designated superview.
        xFromCenter = Float(gestureRecognizer.translationInView(self).x)
        yFromCenter = Float(gestureRecognizer.translationInView(self).y)
        
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            // Save origin position of the view so we can 'snap' back to it later
            self.originPoint = self.center
        case UIGestureRecognizerState.Changed:
            let rotationStrength: Float = min(xFromCenter/ROTATION_STRENGTH, ROTATION_MAX) // returns lesser of x and y
            let rotationAngle = ROTATION_ANGLE * rotationStrength
            // fabsf - Floating point abs function
            let scale = max(1 - fabsf(rotationStrength)/SCALE_STRENGTH, SCALE_MAX)
            
            // New center, original center + current coordinate
            self.center = CGPointMake(self.originPoint.x + CGFloat(xFromCenter), self.originPoint.y + CGFloat(yFromCenter))
            
            // Every time the gesture changes update the scale, rotation transform, and position
            let transform = CGAffineTransformMakeRotation(CGFloat(rotationAngle))
            let scaleTransform = CGAffineTransformScale(transform, CGFloat(scale), CGFloat(scale))
            self.transform = scaleTransform
            self.updateOverlay(CGFloat(xFromCenter))
        case UIGestureRecognizerState.Ended:
            // When the pan gesture ends, animate the view back to the original position and remove transformations
            self.afterSwipeAction()
        case UIGestureRecognizerState.Possible:
            fallthrough
        case UIGestureRecognizerState.Cancelled:
            fallthrough
        case UIGestureRecognizerState.Failed:
            fallthrough
        default:
            break
        }
    }
    
    func updateOverlay(distance: CGFloat) -> Void {
        
    }
    
    func afterSwipeAction() -> Void {
        
    }
    
    
    
}











