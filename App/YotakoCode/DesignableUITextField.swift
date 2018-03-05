//
//  searchBar.swift
//  singleViewApp
//
//  Created by Keuha on 04/01/2018.
//  Copyright © 2018 Yotako S.A. All rights reserved.
//

import Foundation
import UIKit


final class DesignableUITextField: UITextField {
    
    @IBInspectable var iconFromURLString: String! {
        didSet {
            updateView()
        }
    }
    #if !TARGET_INTERFACE_BUILDER
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    @IBInspectable var leftPadding: CGFloat = 10
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }

    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.leftView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

         updateView()
    }
    
    func updateView(){
        if let url = URL(string:iconFromURLString) {
            DispatchQueue.global().async {
              if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if let image:UIImage = UIImage(data: data) {
                            self.leftViewMode = UITextFieldViewMode.always
                            self.imageView.contentMode = .scaleAspectFit
                            self.imageView.image = image
                            self.leftView = self.imageView
                        }
                    }
                }
            }
        }
    }
    #endif
}






