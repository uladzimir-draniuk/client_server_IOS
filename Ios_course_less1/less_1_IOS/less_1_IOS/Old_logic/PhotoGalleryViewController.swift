//
//  PhotoGalleryViewController.swift
//  less_1_IOS
//
//  Created by elf on 25.02.2021.
//

import UIKit
import RealmSwift
import Kingfisher

class PhotoGalleryViewController: UIViewController{
    
    var friend : VKFriend?
    var photoNum : Int?
    
    
    //    let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
    
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var galleryImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
         if let photoNum = self.photoNum {
            if let photoMUrl = getMaxSizePhotoUrl(index: photoNum) {
                self.galleryImageView.kf.setImage(with: photoMUrl)
            }
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
            guard let photoNum = photoNum else { return }
            let newIndex = photoNum + 1
            guard let photosCount = friend?.photos.count else { return }
            let isNewImageL = newIndex < photosCount
            
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
                                        self.galleryImageView.kf.setImage(with: self.getMaxSizePhotoUrl(index: newIndex))
                                        self.photoNum = newIndex
                                        print("animation is done !!!")
                                    }
                                )
                            }
                        }
                )
            
        //right swipe action
        case .right:
            print("right")
            guard let photoNum = photoNum else { return }
            let newIndex = photoNum - 1
            guard let photosCount = friend?.photos.count else { return }
            let isNewImageR = newIndex >= 0 && newIndex < photosCount
            
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
                                        self.galleryImageView.kf.setImage(with: self.getMaxSizePhotoUrl(index: newIndex))
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
    
    func getMaxSizePhotoUrl (index: Int) -> URL? {

        guard let friend = friend else { return .none }
        
        let photo = friend.photos[index]
//        for size in photo.photosSize {
//                if size.type == "p" {
//                    return size.photoUrl
//                }
//            }
         return photo.photosSize.last?.photoUrl
 
    }
}

