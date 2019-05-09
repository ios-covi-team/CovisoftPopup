//
//  ViewController.swift
//  TestPopup
//
//  Created by Kai Luu on 5/9/19.
//  Copyright © 2019 Kai Luu. All rights reserved.
//

import UIKit
import CovisoftPopup

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onTapAction(_ sender: Any) {
        PopupTimePicker.showPopupSetTime(code: "ABC", time: "00:00") { (isOK, time, code) in
            print("\(code), \(time)")
        }
    }
    
}

