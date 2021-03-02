//
//  PhotoGalleryViewController.swift
//  less_1_IOS
//
//  Created by elf on 25.02.2021.
//

import UIKit

class PhotoGalleryViewController: UIViewController{
    
    var data : Friend!
    var photoNum : Int!
    let newView = UIImageView()
    
    //    let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
    
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var galleryImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photoNum = self.photoNum {
            self.galleryImageView.image = UIImage(named: self.data.photos[photoNum])
        }
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.galleryImageView.addGestureRecognizer(leftSwipe)
        self.galleryImageView.addGestureRecognizer(rightSwipe)
        
        self.photoView.addSubview(self.newView)
        
    }
    
    @IBAction func moveToNextItem(_ sender:UISwipeGestureRecognizer) {
        
        switch sender.direction{
        case .left:
            print("left")
            if photoNum + 1 < self.data.photos.count
            {
                self.photoNum += 1
                UIView.animate(
                    withDuration: 1,
                    animations:
                        {
                            self.galleryImageView.image = UIImage(named: self.data.photos[self.photoNum])
                        },
                    completion:
                        {_ in
                            print("animation is done!!!")
                        }
                )
                //                self.photoNum += 1
                //                self.newView.frame = self.ÍgalleryImageView.frame
                //                self.newView.image = UIImage(named: self.data.photos[self.photoNum])
                //
                //                UIView.transition(
                //                    from: self.galleryImageView,
                //                    to: newView,
                //                    duration: 1,
                //                    options: .transitionCrossDissolve
                //                )
            }
            
        //left swipe action
        case .right:
            print("right")
            if self.photoNum - 1 >= 0 && self.photoNum - 1 < self.data.photos.count
            {
                self.photoNum -= 1
                //                                self.newView.frame = self.galleryImageView.frame
                //                                self.newView.image = UIImage(named: self.data.photos[self.photoNum])
                //
                //                UIView.transition(
                //                    from: self.galleryImageView,
                //                    to: self.newView,
                //                    duration: 1,
                //                    options: .transitionCrossDissolve
                //                )
                //                self.photoNum -= 1
                
                let animation = CABasicAnimation(keyPath: "position.x")
                animation.fromValue = self.galleryImageView.layer.position.x
                animation.toValue = self.galleryImageView.layer.position.x + 20
                animation.duration = 3
                animation.fillMode = .backwards
                self.galleryImageView.layer.add(animation, forKey: nil)
                
                UIView.animate(
                    withDuration: 0.6,
                    animations:
                        {
                            self.galleryImageView.image = UIImage(named: self.data.photos[self.photoNum])
                        },
                    completion:
                        {_ in
                            //                            UIView.transition(
                            //                                                from: self.galleryImageView,
                            //                                                to: self.newView,
                            //                                                duration: 1,
                            //                                                options: .transitionCrossDissolve)
                            //                            UIView.animate(
                            //                                withDuration: 0.5,
                            //                                animations:
                            //                                    {
                            //
                            //                                        self.galleryImageView.image = UIImage(named: self.data.photos[self.photoNum])
                            //                                    },
                            //                                completion:
                            //                                    {_ in
                            print("animation is done,!!!")
                        })
            }
//            )
//        }
        //right swipe action
        default: //default
        print("-")
    }
    
}
}
