//
//  PopoverOption.swift
//  Pods
//
//  Created by Mohamed on 04/03/2017.
//
//

import Foundation
public enum PopoverOption {
    case type(PopoverType)
    case color(UIColor)
    case arrowSize(CGSize)
    case animationIn(TimeInterval)
    case animationOut(TimeInterval)
    case cornerRaduis(CGFloat)
    case sideEdge(CGFloat)
    case overlayColor(UIColor)
    case overlayBlur(UIBlurEffectStyle)
}
