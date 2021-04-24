//
//  LikesControlButton.swift
//  less_1_IOS
//
//  Created by elf on 15.02.2021.
//

import UIKit
final class LoadingBar: UIView {
    
    let circle1 = UIView()
    let circle2 = UIView()
    let circle3 = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.addSubview(self.circle1)
        self.circle1.backgroundColor = .blue
        self.circle1.layer.cornerRadius = 6
        self.circle1.clipsToBounds = true
        
        self.circle1.translatesAutoresizingMaskIntoConstraints = false
        self.circle1.widthAnchor.constraint(equalToConstant: 12).isActive = true
        self.circle1.heightAnchor.constraint(equalToConstant: 12).isActive = true
        self.circle1.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.circle1.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.circle1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
        self.addSubview(self.circle2)
        self.circle2.backgroundColor = .blue
        self.circle2.layer.cornerRadius = 6
        self.circle2.clipsToBounds = true
        
        self.circle2.translatesAutoresizingMaskIntoConstraints = false
        self.circle2.widthAnchor.constraint(equalToConstant: 12).isActive = true
        self.circle2.heightAnchor.constraint(equalToConstant: 12).isActive = true
        self.circle2.leadingAnchor.constraint(equalTo: self.circle1.trailingAnchor, constant: 6).isActive = true
        self.circle2.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.circle2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        self.addSubview(self.circle3)
        self.circle3.backgroundColor = .blue
        self.circle3.layer.cornerRadius = 6
        self.circle3.clipsToBounds = true
        
        self.circle3.translatesAutoresizingMaskIntoConstraints = false
        self.circle3.widthAnchor.constraint(equalToConstant: 12).isActive = true
        self.circle3.heightAnchor.constraint(equalToConstant: 12).isActive = true
        self.circle3.leadingAnchor.constraint(equalTo: self.circle2.trailingAnchor, constant: 6).isActive = true
        self.circle3.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.circle3.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.circle3.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation()
    {
        UIView.animateKeyframes(
            withDuration: 0.9,
            delay: 0,
            options: .repeat,
            animations:
                {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3,
                                       animations: {
                                        self.circle1.alpha = 0
                                        self.circle3.alpha = 1
                                       } )
                    UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.6,
                                       animations: {
                                        self.circle1.alpha = 1
                                        self.circle2.alpha = 0
                                       } )
                    UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.9,
                                       animations: {
                                        self.circle2.alpha = 1
                                        self.circle3.alpha = 0
                                       } )
                },
            completion:
                {_ in
                    self.circle1.alpha = 0
                    self.circle2.alpha = 0
                    self.circle3.alpha = 0
                })
        
    }
}

