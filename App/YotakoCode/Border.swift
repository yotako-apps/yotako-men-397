//
//  Border.swift
//  singleViewApp
//
//  Created by Keuha on 04/01/2018.
//  Copyright © 2018 Yotako S.A. All rights reserved.
//
private struct AssociatedKeys {
    static var addBorderTop = "addBorderTop"
    static var addBorderBottom = "addBorderBottom"
    static var addBorderLeft = "addBorderLeft"
    static var addBorderRight = "addBorderRight"
    static var addBorderTopLayer = "addBorderTopLayer"
    static var addBorderBottomLayer = "addBorderBottomLayer"
    static var addBorderLeftLayer = "addBorderLeftLayer"
    static var addBorderRightLayer = "addBorderRightLayer"
    static var observer = "observer"
    
}

import Foundation
import ObjectiveC
import UIKit
@IBDesignable extension UIView {
   
    func updateBorder() {
        if let observer : NSKeyValueObservation = objc_getAssociatedObject(self, &AssociatedKeys.observer)  as? NSKeyValueObservation {
            observer.invalidate()
        }
        if addBorderTop > 0  {
            _ = self.addBorderUtility(0, y: 0, width:self.bounds.size.width, height: addBorderTop)
        }
        if addBorderBottom > 0 {
            _ = self.addBorderUtility(0, y: self.bounds.size.height, width:self.bounds.size.width, height: addBorderBottom)
        }
        if addBorderRight > 0 {
            _ = self.addBorderUtility(0, y: 0, width:addBorderRight, height: self.bounds.size.height)
        }
        if addBorderLeft > 0 {
            _ = self.addBorderUtility(self.bounds.size.width - addBorderLeft, y:0, width: addBorderLeft, height: self.bounds.size.height)
        }
    }
    
    @IBInspectable var addBorderTop: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.addBorderTop, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &AssociatedKeys.addBorderTopLayer,
                                     self.addBorderUtility(0, y: 0, width:self.bounds.size.width, height: newValue),
                                      objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self,&AssociatedKeys.addBorderTop) {
                self.removeBorderFromUtility(&AssociatedKeys.addBorderTopLayer)
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    @IBInspectable var addBorderBottom: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.addBorderBottom, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &AssociatedKeys.addBorderBottomLayer,
                                     self.addBorderUtility(0, y: self.bounds.size.height, width:self.bounds.size.width, height: newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.addBorderBottom) {
            self.removeBorderFromUtility(&AssociatedKeys.addBorderBottomLayer)
               return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    @IBInspectable var addBorderLeft: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.addBorderLeft, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &AssociatedKeys.addBorderLeftLayer,
                                     self.addBorderUtility(0, y: 0, width:newValue, height: self.bounds.size.height),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.addBorderLeft) {
                self.removeBorderFromUtility(&AssociatedKeys.addBorderLeftLayer)
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    @IBInspectable var addBorderRight: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.addBorderRight, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &AssociatedKeys.addBorderRightLayer,
                                     self.addBorderUtility(self.bounds.size.width - newValue, y:0, width: newValue, height: self.bounds.size.height),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
       }
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.addBorderRight) {
                self.removeBorderFromUtility(&AssociatedKeys.addBorderRightLayer)
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    private func removeBorderFromUtility(_ ptr:UnsafePointer<String>) {
        if let value: CALayer  = objc_getAssociatedObject(self, ptr) as? CALayer {
            value.removeFromSuperlayer()
        }
    }
    
    private func addBorderUtility(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CALayer {
        objc_setAssociatedObject(self, &AssociatedKeys.observer,
                                 self.layer.observe(\.bounds) { object, _ in
                                    self.updateBorder()
        }, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        let border = CALayer()
        border.backgroundColor = self.layer.borderColor;
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
        return border;
    }
}
