//
//  OverlayView.swift
//  ITVW
//
//  Created by Rachel Schifano on 5/12/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

enum VWOverlayViewMode {
    case VWOverlayViewModeLeft
    case VWOverlayViewModeRight
}

// Action overlay to appear when swiping
class OverlayView: UIView {
    var _mode: VWOverlayViewMode! = VWOverlayViewMode.VWOverlayViewModeLeft // Default?
    var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        imageView = UIImageView(image: UIImage(named: "noButton"))
        self.addSubview(imageView)
    }
    
    /*
        Sets the corresponding overlay image for either the left or right mode.
        - Parameter mode: The current VWOverlayViewMode of either left or right
    */
    func setMode(mode: VWOverlayViewMode) -> Void {
        // Base case, if modes are the same
        if _mode == mode {
            return
        }
        
        // Check the given mode and set the corresponding overlay image
        _mode = mode
        if _mode == VWOverlayViewMode.VWOverlayViewModeLeft {
            imageView.image = UIImage(named: "noButton")
        } else { // swipe right
            imageView.image = UIImage(named: "yesButton")
        }
    }
    
    /*
        Sets the frame of the overlay image view.
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRectMake(50,50,100,100)
    }
}