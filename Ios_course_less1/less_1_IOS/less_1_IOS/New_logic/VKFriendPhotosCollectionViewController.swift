//
//  VKFriendPhotosCollectionViewController.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//

import UIKit
import Kingfisher
import RealmSwift


private let reuseIdentifier = "Cell"

class VKFriendPhotosCollectionViewController: UICollectionViewController {

    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    private var photos: [VKPhoto] = []
    
    private let reuseIdentifier = "PhotoCell"
    var data : VKFriend?
    
    private lazy var friend: VKFriend? =
        data.flatMap {
            try? Realm(configuration: RealmAdds.deleteIfMigration)
                .object(ofType: VKFriend.self, forPrimaryKey: $0.id)
        }
    
    var currIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView.register(UINib(nibName: "FriendPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.reuseIdentifier)

        guard let friend = friend else { return }

        self.navigationItem.title = friend.lastName + " " + friend.firstName

     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let friendId = friend?.id {
            netSession.loadPics(owner: friendId, completionHandler: { [weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(photos):
                    guard let friend = self?.friend else { return }
                    do {
                        let realm = try Realm()
                        try realm.write {
                            friend.photos.removeAll()
                            friend.photos.append(objectsIn: photos)
                        }
                        self?.photos = photos
                    } catch {
                        print(error)
                    }
                    self?.collectionView.reloadData()
                }
            })
        }
     }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        currIndex = indexPath
        performSegue(withIdentifier: "showFriendImages", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let indexPath = currIndex , segue.identifier == "showFriendImages" else { return }
        
        let vc = segue.destination as? VKPhotoGalleryViewController
        vc?.photoNum = indexPath.row
        vc?.friend = friend
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotosCollectionViewCell
        
        if indexPath.item < photos.count {
            if let photoMUrl = getPSizePhotoUrl(index: indexPath.row) {
                cell.photoFriend.kf.setImage(with: photoMUrl)
            } else {
                cell.photoFriend.kf.setImage(with: friend?.photoUrl)
            }
        }
        return cell
    }
    
   
    func getPSizePhotoUrl (index: Int) -> URL? {

        let photo = photos[index]
        for size in photo.photosSize {
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
