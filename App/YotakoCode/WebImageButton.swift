//
//  WebImageButton.swift
//  singleViewApp
//
//  Created by Keuha on 03/01/2018.
//  Copyright © 2018 Yotako S.A. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    @IBInspectable var stringUrl: String {
        get {
            return ""
        }
        set {
            let url = URL(string:newValue)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!) {//make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.setBackgroundImage(UIImage(data: data), for: .normal)
                    }
                }
            }
        }
    }
}
