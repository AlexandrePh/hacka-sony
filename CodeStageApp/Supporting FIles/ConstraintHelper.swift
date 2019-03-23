//
//  ConstraintHelper.swift
//  GaioApp
//
//  Created by Alexandre Philippi on 22/09/18.
//  Copyright © 2018 Gaio. All rights reserved.


import UIKit

class UI{
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

extension UIView{
    func deactivateAllConstraints(){
        for constraint in self.constraints{
            constraint.isActive = false
        }
    }
}



func width(from x: Double)->CGFloat{
    let screenWidth = Double(UIScreen.main.bounds.width)
    let newX = (x * screenWidth)/375.0
    return CGFloat(newX)
}

func heigth(from y: Double)->CGFloat{
    let screenHeight = Double(UIScreen.main.bounds.height)
    let newY = (y * screenHeight)/667.0
    return CGFloat(newY)
}
//MARK: - Constrain classes extensions


@objc extension NSLayoutAnchor {
    
    
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to anchor: NSLayoutAnchor,
                   with constant: CGFloat = 0.0,
                   prioritizeAs priority: UILayoutPriority = .required,
                   isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalTo: anchor, constant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualTo: anchor, constant: constant)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
}
extension NSLayoutDimension {
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to anchor: NSLayoutDimension,
                   with constant: CGFloat = 0.0,
                   multiplyBy multiplier: CGFloat = 1.0,
                   prioritizeAs priority: UILayoutPriority = .required,
                   isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to constant: CGFloat = 0.0,
                   prioritizeAs priority: UILayoutPriority = .required,
                   isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalToConstant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualToConstant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualToConstant: constant)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
}

extension UILayoutPriority {
    
    static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue + rhs)
    }
    
    static func -(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue - rhs)
    }
}


//MARK: - UIView Constrains Extension
extension UIView {
    
    func addSubviewsUsingAutoLayout(_ views: UIView ...) {
        
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func fillSuperview() {
        
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
//    func sizeAnchors(width: CGFloat = 0, height: CGFloat = 0){
//        if width != 0 {
//            let constrain =  self.widthAnchor.constraint(equalToConstant: width)
//            constrain.isActive = true
//            
//        }
//        
//        if height != 0 {
//            let constrain = self.heightAnchor.constraint(equalToConstant: height)
//            constrain.isActive = true
//        }
//    }
    func sizeAnchors(width: CGFloat?, height: CGFloat?, priority:UILayoutPriority = .required){
        if let width = width {
            let constrain =  self.widthAnchor.constraint(equalToConstant: width)
            
            constrain.priority = priority
            constrain.isActive = true
            
        }
        
        if let height = height {
            let constrain = self.heightAnchor.constraint(equalToConstant: height)
            
            constrain.priority = priority
            constrain.isActive = true
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constrain(to: top, with: padding.top)
        }
        
        if let leading = leading {
            leadingAnchor.constrain(to: leading,with: padding.left)
        }
        if let bottom = bottom {
            bottomAnchor.constrain(to: bottom,with: -padding.bottom)
        }
        
        if let trailing = trailing {
            trailingAnchor.constrain(to: trailing, with: -padding.right)
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
