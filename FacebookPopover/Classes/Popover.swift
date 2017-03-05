//
//  Popover.swift
//  Pods
//
//  Created by Mohamed on 04/03/2017.
//
//

import Foundation
public class Popover: UIView {
    
    //MARK: - Public Properties
    public typealias PopoverHandler = () -> ()
    public fileprivate(set) var popoverType: PopoverType = .up
    public fileprivate(set) var popoverColor: UIColor = .white
    public fileprivate(set) var arrowSize = CGSize(width: 16, height: 10)
    public fileprivate(set) var animationIn = 0.6
    public fileprivate(set) var animationOut = 0.6
    public fileprivate(set) var cornerRadius: CGFloat = 6.0
    public fileprivate(set) var sideEdge: CGFloat = 20.0
    public fileprivate(set) var overlayColor = UIColor(white: 0.0, alpha: 0.2)
    public fileprivate(set) var overlayBlur: UIBlurEffect?
    
    //MARK: - Private Properties
    fileprivate var isCornerLeftArrow: Bool {
        return arrowShowPoint.x == frame.origin.x
    }
    fileprivate var isCornerRightArrow: Bool {
        return arrowShowPoint.x == frame.origin.x + bounds.width
    }
    fileprivate var arrowShowPoint: CGPoint!
    fileprivate var contentView: UIView!
    fileprivate var containerView: UIView!
    fileprivate var showHandler: PopoverHandler?
    fileprivate var dismissHandler: PopoverHandler?
    fileprivate var blackOverlay = UIControl()
    fileprivate var option: [PopoverOption]? {
        set {
            guard let options = newValue else {
                return
            }
            options.forEach { (popoverOption) in
                switch popoverOption {
                case .type(let value):
                    popoverType = value
                case .color(let value):
                    popoverColor = value
                case .arrowSize(let value):
                    arrowSize = value
                case .animationIn(let value):
                    animationIn = value
                case .animationOut(let value):
                    animationOut = value
                case .cornerRaduis(let value):
                    cornerRadius = value
                case .sideEdge(let value):
                    sideEdge = value
                case .overlayBlur(let value):
                    overlayBlur = UIBlurEffect(style: value)
                default: break
                }
            }
        }
        get {
            return self.option
        }
    }
    //MARK: - Life Cycle
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let arrow = UIBezierPath()
        let  arrowPoint = containerView.convert(arrowShowPoint, to: self)
        switch popoverType {
        case .up:
            arrow.move(to: CGPoint(x: arrowPoint.x, y: bounds.height))
            arrow.addLine(to: CGPoint(x: arrowPoint.x - arrowSize.width * 0.5, y: isCornerLeftArrow ? arrowSize.height : bounds.height - arrowSize.height))
            arrow.addLine(to: CGPoint(x: CGFloat(cornerRadius), y: bounds.height - arrowSize.height))
            arrow.addArc(withCenter: CGPoint(x: cornerRadius, y: bounds.height - arrowSize.height - cornerRadius), radius: cornerRadius, startAngle: radians(degrees: 90), endAngle: radians(degrees: 180), clockwise: true)
            arrow.addLine(to: CGPoint(x: 0, y: cornerRadius))
            arrow.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius
            ), radius: cornerRadius, startAngle: radians(degrees: 180), endAngle: radians(degrees: 270), clockwise: true)
            arrow.addLine(to: CGPoint(x: self.bounds.width - cornerRadius, y: 0));
            arrow.addArc(withCenter: CGPoint(x: bounds.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: radians(degrees: 270), endAngle: radians(degrees: 0), clockwise: true)
            arrow.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - self.arrowSize.height - self.cornerRadius))
            arrow.addArc(withCenter: CGPoint(x: bounds.width - cornerRadius, y: bounds.height - arrowSize.height - cornerRadius), radius: cornerRadius, startAngle: radians(degrees: 0), endAngle: radians(degrees: 90), clockwise: true)
            arrow.addLine(to: CGPoint(x: arrowPoint.x + self.arrowSize.width * 0.5, y: isCornerRightArrow ? self.arrowSize.height : self.bounds.height - self.arrowSize.height))
        case .down:
            arrow.move(to: CGPoint(x: arrowPoint.x, y: 0))
            arrow.addLine(to: CGPoint(x: arrowPoint.x + self.arrowSize.width * 0.5, y: isCornerRightArrow ? self.arrowSize.height + self.bounds.height : self.arrowSize.height))
            arrow.addLine(to: CGPoint(x: self.bounds.width - self.cornerRadius, y: self.arrowSize.height))
            arrow.addArc(withCenter: CGPoint(x: self.bounds.width - self.cornerRadius, y: self.arrowSize.height + self.cornerRadius
                ), radius: self.cornerRadius, startAngle: self.radians(degrees: 270.0), endAngle: self.radians(degrees: 0), clockwise: true)
            arrow.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - self.cornerRadius))
            arrow.addArc(withCenter: CGPoint(x: self.bounds.width - self.cornerRadius, y: self.bounds.height - self.cornerRadius), radius: self.cornerRadius, startAngle: self.radians(degrees: 0), endAngle: self.radians(degrees: 90), clockwise: true)
            arrow.addLine(to: CGPoint(x: 0, y: self.bounds.height))
            arrow.addArc(withCenter: CGPoint(x: self.cornerRadius, y: self.bounds.height - self.cornerRadius), radius: self.cornerRadius, startAngle: self.radians(degrees: 90), endAngle: self.radians(degrees: 180), clockwise: true)
            arrow.addLine(to: CGPoint(x: 0, y: self.arrowSize.height + self.cornerRadius))
            arrow.addArc(withCenter: CGPoint(x: self.cornerRadius, y: self.arrowSize.height + self.cornerRadius), radius: self.cornerRadius, startAngle: self.radians(degrees: 180),endAngle: self.radians(degrees: 270), clockwise: true)
            arrow.addLine(to: CGPoint(x: arrowPoint.x - self.arrowSize.width * 0.5, y: isCornerLeftArrow ? self.arrowSize.height + self.bounds.height : self.arrowSize.height))
        }
        
        popoverColor.setFill()
        arrow.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(showHandler: PopoverHandler?, dismissHandler: PopoverHandler?) {
        super.init(frame: .zero)
        backgroundColor = .clear
        self.showHandler = showHandler
        self.dismissHandler = dismissHandler
    }
    
    //MARK: - Actions
    @IBAction func dismissAction() {
        dismiss()
    }
}

//MARK: - init
public extension Popover {
    convenience init(option: [PopoverOption]?, showHandler: PopoverHandler? = nil, dismissHandler: PopoverHandler? = nil) {
        self.init(showHandler: showHandler, dismissHandler: dismissHandler);
        self.option = option
    }
}

//MARK: - Public Methods
public extension Popover {
    func show(content contentView: UIView, from fromView : UIView) {
        show(content: contentView, from: fromView, in: UIApplication.shared.keyWindow!)
    }
    
    func show(content contentView: UIView, from fromView : UIView, in inView: UIView) {
        let point: CGPoint
        switch popoverType {
        case .up:
            point = inView.convert(CGPoint(x: fromView.frame.origin.x + (fromView.frame.size.width / 2), y: fromView.frame.origin.y), to: fromView.superview)
        case .down:
            point = inView.convert(CGPoint(x: fromView.frame.origin.x + (fromView.frame.size.width / 2), y: fromView.frame.origin.y + fromView.frame.size.height), to: fromView.superview)
        }
        show(content: contentView, point: point, in: inView)
    }
    
    func show(content contentView: UIView, point: CGPoint) {
        show(content: contentView, point: point, in:  UIApplication.shared.keyWindow!)
    }
    
    func show(content contentView: UIView, point: CGPoint, in inView: UIView) {
        blackOverlay.addTarget(self, action: #selector(Popover.dismissAction), for: .touchUpInside)
        blackOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blackOverlay.frame = inView.bounds
        
        if let overlayBlur = overlayBlur {
            let effectView = UIVisualEffectView(effect: overlayBlur)
            effectView.frame = blackOverlay.bounds
            effectView.isUserInteractionEnabled = false
            self.blackOverlay.addSubview(effectView)
        } else {
            blackOverlay.backgroundColor = overlayColor
            blackOverlay.alpha = 0
        }
        inView.addSubview(blackOverlay)
        containerView = inView
        self.contentView = contentView
        self.contentView.backgroundColor = .clear
        self.contentView.layer.cornerRadius = self.cornerRadius
        self.contentView.layer.masksToBounds = true
        arrowShowPoint = point
        show()
    }
}

//MARK: - Private Methods
fileprivate extension Popover {
    
    func show() {
        setNeedsDisplay()
        switch popoverType {
        case .up:
            contentView.frame.origin.y = 0.0
        case .down:
            contentView.frame.origin.y = self.arrowSize.height
        }
        self.addSubview(self.contentView)
        self.containerView.addSubview(self)
        create()
        transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: animationIn, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
            self.blackOverlay.alpha = 1
            self.transform = CGAffineTransform.identity

            }) { (_) in
                self.showHandler?()
        }
    }
    
    func dismiss() {
        
        if self.superview != nil {
            
            UIView.animate(withDuration: animationOut, delay: 0, options: .curveEaseInOut, animations: { 
                self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                self.blackOverlay.alpha = 0

                }, completion: { (_) in
                    self.contentView.removeFromSuperview()
                    self.blackOverlay.removeFromSuperview()
                    self.removeFromSuperview()
                    self.dismissHandler?()
            })
        }
    }
    
    func create() {
        var frame = contentView.frame
        frame.origin.x = arrowShowPoint.x - frame.size.width * 0.5
        
        var sideEdge: CGFloat = 0.0
        if frame.size.width < containerView.frame.size.width {
            sideEdge = self.sideEdge
        }
        
        let outerSideEdge = frame.maxX - containerView.bounds.size.width
        if outerSideEdge > 0 {
            frame.origin.x -= (outerSideEdge + sideEdge)
        } else {
            if frame.minX < 0 {
                frame.origin.x += abs(frame.minX) + sideEdge
            }
        }
        self.frame = frame
        
        let arrowPoint = containerView.convert(arrowShowPoint, to: self)
        let anchorPoint: CGPoint
        switch self.popoverType {
        case .up:
            frame.origin.y = arrowShowPoint.y - frame.height - self.arrowSize.height
            anchorPoint = CGPoint(x: arrowPoint.x / frame.size.width, y: 1)
        case .down:
            frame.origin.y = arrowShowPoint.y
            anchorPoint = CGPoint(x: arrowPoint.x / frame.size.width, y: 0)
        }
        
        let lastAnchor = layer.anchorPoint
        layer.anchorPoint = anchorPoint
        let x = layer.position.x + (anchorPoint.x - lastAnchor.x) * self.layer.bounds.size.width
        let y = layer.position.y + (anchorPoint.y - lastAnchor.y) * self.layer.bounds.size.height
        layer.position = CGPoint(x: x, y: y)
        frame.size.height += self.arrowSize.height
        self.frame = frame
    }
    
    func radians(degrees: CGFloat) -> CGFloat {
        return (CGFloat(M_PI) * degrees / 180)
    }
}
