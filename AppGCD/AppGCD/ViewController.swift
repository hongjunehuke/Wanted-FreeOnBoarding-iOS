//
//  AppGCD - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private var views: [LusterView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        views.forEach { $0.reset() }
    }

    @IBAction private func touchUpLoadAllImageButton(_ sender: UIButton) {
        
        views.forEach { $0.loadImage() }
    }

}

