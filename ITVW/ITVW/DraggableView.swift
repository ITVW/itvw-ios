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
    var panGestureRecognizer: UIPanGestureRecognizer!
    var originPoint: CGPoint!
    var xFromCenter: Float!
    var yFromCenter: Float!
    var overlayView: OverlayView!
    var vaporwaveImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor() // FIXME: Does not need to be in init?
        self.setupView()
        
        // Add image view to hold images
        vaporwaveImageView = UIImageView(frame: CGRectMake(0,50,290,386))
        
        // TODO: Add information if necessary here
        
        // Create new pan gesture recognizer for swiping actions
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DraggableView.beingDragged(_:)))
        self.addGestureRecognizer(panGestureRecognizer) 
        self.addSubview(vaporwaveImageView)
        
        // Create and hide the overlay
        overlayView = OverlayView(frame: CGRectMake(self.frame.size.width/2-100, 0, 100, 100))
        overlayView.alpha = 0
        self.addSubview(overlayView)
        
        xFromCenter = 0
        yFromCenter = 0
    }
    
    /*
        Sets up the view to look like a generic card, including rounded corners, shadow radius.
    */
    func setupView() -> Void {
        self.layer.cornerRadius = 4 // The radius to use when drawing rounded corners for the layer's background
        self.layer.shadowRadius = 3 // The blur radius in points used to render the layer's shadow
        self.layer.shadowOpacity = 0.2 // The opacity of the layer's shadow
        self.layer.shadowOffset = CGSizeMake(1,1) // The offset in points of the layer's shadow (width, height)
    }
    
    /*
        Method checks the state of the provided pan gesture recognizer. For each state change of the recognizer, the scale, rotation transformation, and position properties of the view are updated.
     
        - Parameter gestureRecognizer: The current UIPanGestureRecognizer
    */
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
    
    /*
        Checks the distance the draggable view has moved on the x-axis, determines if the overlay mode corresponds to left or right, and updates the corresponding overlay image.
     
        - Parameter distance: The distance on the x-axis the draggable view has moved
    */
    func updateOverlay(distance: CGFloat) -> Void {
        if distance > 0 {
            // Moving in positive direction = right
            overlayView.setMode(VWOverlayViewMode.VWOverlayViewModeRight)
        } else {
            // Moving in negative direction = left
            overlayView.setMode(VWOverlayViewMode.VWOverlayViewModeLeft)
        }
    }
    
    /*
        Checks if the draggable view has moved on the x-axis passed either the left (-120) or right (120) swipe action threshold and calls the corresponding action.
    */
    func afterSwipeAction() -> Void {
        let floatXFromCenter = Float(xFromCenter)
        if floatXFromCenter > ACTION_MARGIN { // ACTION_MARGIN = 120
            self.rightAction()
        } else if floatXFromCenter < -ACTION_MARGIN {
            self.leftAction()
        } else {
            // TODO: Seems to hide the overlay and...animation?
            UIView.animateWithDuration(0.3, animations: {() -> Void in
                self.center = self.originPoint
                self.transform = CGAffineTransformMakeRotation(0)
                self.overlayView.alpha = 0
            })
        }
    }
    
    // TODO: Why did they use 500 and -500? View goes off screen?
    func rightAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(500, 2 * CGFloat(yFromCenter) + self.originPoint.y)
        UIView.animateWithDuration(0.3,
               animations: {
                self.center = finishPoint
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(self)
    }
    
    func leftAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(-500, 2 * CGFloat(yFromCenter) + self.originPoint.y)
        UIView.animateWithDuration(0.3,
               animations: {
                self.center = finishPoint
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(self)
    }
    
    // TODO: What does click action do?
    func rightClickAction() -> Void {
        let finishPoint = CGPointMake(600, self.center.y)
        UIView.animateWithDuration(0.3,
               animations: {
                self.center = finishPoint
                self.transform = CGAffineTransformMakeRotation(1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(self)
    }
    
    func leftClickAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(-600, self.center.y)
        UIView.animateWithDuration(0.3,
               animations: {
                self.center = finishPoint
                self.transform = CGAffineTransformMakeRotation(1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(self)
    }
}