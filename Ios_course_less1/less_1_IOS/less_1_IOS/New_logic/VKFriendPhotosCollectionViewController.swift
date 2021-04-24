//
//  VKFriendPhotosCollectionViewController.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class VKFriendPhotosCollectionViewController: UICollectionViewController {

    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    private let reuseIdentifier = "PhotoCell"
    var data : VKFriend!
    var currIndex: IndexPath?
    var photos : [VKPhoto] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView.register(UINib(nibName: "FriendPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.reuseIdentifier)

        guard let friend = self.data else { return }
        // Do any additional setup after loading the view.
        self.navigationItem.title = data.lastName + " " + data.firstName

     }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.currIndex = indexPath
        self.performSegue(withIdentifier: "showFriendImages", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let indexPath = self.currIndex , segue.identifier == "showFriendImages" else { return }
        
        let vc = segue.destination as? PhotoGalleryViewController
 //       vc?.data = self.data
        vc?.photoNum = indexPath.row
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let isGood = self.photos.first {
            if let count = self.photos[0].count,
               count > 0 {
                return count
            }
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotosCollectionViewCell
        
        let count = self.photos.count
        if indexPath.item < count {
            if let photoMUrl = getMSizePhotoUrl(index: indexPath.row) {
                cell.photoFriend.kf.setImage(with: photoMUrl)
            } else {
                cell.photoFriend.kf.setImage(with: self.data?.photoUrl)
            }
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        netSession.loadPics(owner: data.id, completionHandler: { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(photos):
                self.photos = photos
                self.collectionView.reloadData()
            
            }
        })
    }
    
    func getMSizePhotoUrl (index: Int) -> URL? {
        let photo = self.photos[index]
            for size in photo.photos {
                if size.type == "p" {
                    return size.photoUrl
                }
            }

        return .none
        }
}

extension VKFriendPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
