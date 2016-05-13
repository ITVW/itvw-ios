//
//  ViewController.swift
//  ITVW
//
//  Created by Rachel Schifano on 5/12/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let draggableViewBackground: DraggableViewBackground = DraggableViewBackground(frame: self.view.frame)
        self.view.addSubview(draggableViewBackground)
    }
}