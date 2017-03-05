//
//  CustomView.swift
//  FacebookPopover
//
//  Created by Mohamed on 05/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

fileprivate extension CustomView {
    func commonInit() {
        let view  =  Bundle.main.loadNibNamed(String(describing: CustomView.self), owner: self, options: nil)?[0] as! UIView
        view.frame = bounds;
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
