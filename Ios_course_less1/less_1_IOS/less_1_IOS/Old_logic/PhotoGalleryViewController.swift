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
        
    }
    
    @IBAction func moveToNextItem(_ sender:UISwipeGestureRecognizer) {
        
        let newImage = UIImageView()
        switch sender.direction{
        //left swipe action
        case .left:
            print("left")
            let newIndex = self.photoNum + 1
            let isNewImageL = newIndex < self.data.photos.count
            
            UIView.animate(
                    withDuration: 0.4,
                    animations: { self.photoView.frame.origin.x -= 40 },
                    completion:
                        {_ in
                            self.photoView.center.x += 40
                            if isNewImageL
                            {
                                newImage.removeFromSuperview()
                                UIView.animate(
                                withDuration: 0.6,
                                animations:
                                    {
                                        self.galleryImageView.image = UIImage(named: self.data.photos[newIndex])
                                        self.photoNum = newIndex
                                        print("animation is done,!!!")
                                    }
                                )
                            }
                        }
                )
            
        //right swipe action
        case .right:
            print("right")
            let newIndex = self.photoNum - 1
            let isNewImageR = newIndex >= 0 && newIndex < self.data.photos.count
            
            UIView.animate(
                withDuration: 0.4,
                animations: { self.galleryImageView.frame.origin.x += 40 },
                completion:
                    {_ in
                        self.galleryImageView.center.x -= 40
                        if isNewImageR
                        {
                            UIView.animate(
                                withDuration: 0.6,
                                animations:
                                    {
                                        self.galleryImageView.image = UIImage(named: self.data.photos[newIndex])
                                        print("animation is done,!!!")
                                        self.photoNum = newIndex
                                    }
                            )
                        }
                    }
            )
            
        default: //default
            print("-")
        }
    }
}
