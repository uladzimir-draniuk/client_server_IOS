//
//  AvatarView.swift
//  less_1_IOS
//
//  Created by elf on 14.02.2021.
//

import UIKit

@IBDesignable
class AvatarView : UIView {
    
    @IBOutlet var imageView : UIImageView! {
        didSet {
            self.imageView.layer.cornerRadius = self.cornerRadius
            self.imageView.clipsToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shaddowOffset : CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shaddowOffset
        }
    }
    
    @IBInspectable var capacity : Float = 0.8 {
        didSet {
            self.layer.shadowOpacity = capacity
        }
    }
    @IBInspectable var shadowColor : UIColor = .black {
        didSet {
            self .layer.shadowColor = shadowColor.cgColor
        }
    }
}

