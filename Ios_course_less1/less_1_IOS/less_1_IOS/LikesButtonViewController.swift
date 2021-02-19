//
//  ViewController1.swift
//  less_1_IOS
//
//  Created by elf on 30.01.2021.
//

import UIKit

class ViewController2: UIViewController {
    
    var currentLikes = 1
    
    lazy var likeButton = LikesButton(initialState: .disliked(self.currentLikes))

    
    var isNeededToLike = true
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(self.likeButton)
            self.likeButton.addTarget(self, action: #selector(handleLikeTap), for: .touchUpInside)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            self.likeButton.frame = CGRect(x: 150, y: 400, width: 50, height: 25)
        }
        
        var viewIsShown = true
        
        @objc
        func handleLikeTap() {
            if self.isNeededToLike {
                self.currentLikes += 1
                self.likeButton.applyState(.liked(self.currentLikes))
            } else {
                self.currentLikes -= 1
                self.likeButton.applyState(.disliked(self.currentLikes))
            }

            self.isNeededToLike.toggle()
        }
    }
