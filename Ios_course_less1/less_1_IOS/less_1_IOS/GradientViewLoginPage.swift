//
//  GradientViewLoginPage.swift
//  less_1_IOS
//
//  Created by elf on 13.02.2021.
//

import UIKit

class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor? {
        didSet {
            setupGradientColor()
        }
    }
    
    @IBInspectable private var endColor: UIColor? {
        didSet {
            setupGradientColor()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setupGradientColor()
    }
    
    private func setupGradientColor() {
        if let startColor = startColor, let endColor = endColor {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    
}
