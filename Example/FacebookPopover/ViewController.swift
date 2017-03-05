//
//  ViewController.swift
//  FacebookPopover
//
//  Created by mohamedghebaji on 03/04/2017.
//  Copyright (c) 2017 mohamedghebaji. All rights reserved.
//

import UIKit
import FacebookPopover

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showDownPopoverAction(sender: UIButton) {
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 180))
        let popover = Popover(option: [.type(.down), .color(.red), .cornerRaduis(60)])
        popover.show(content: aView, from: sender)
    }
    
    @IBAction func showUpPopoverAction(sender: UIButton) {
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        let popover = Popover(option: [.type(.up), .color(.green), .cornerRaduis(0.0)])
        popover.show(content: aView, from: sender)
    }
}

