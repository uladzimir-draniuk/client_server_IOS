//
//  PhotosCollectionViewController.swift
//  less_1_IOS
//
//  Created by elf on 09.02.2021.
//

import UIKit



class PhotosCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "PhotoCell"
    var data : Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()


//        self.collectionView.addSubview(self.likeButton)
        
        // Register cell classes
        self.collectionView.register(UINib(nibName: "FriendPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.reuseIdentifier)

        // Do any additional setup after loading the view.
        self.navigationItem.title = data.surname + " " + data.name
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.photos.count
    }

    
//    let likeButton = LikesButton()
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotosCollectionViewCell
        if indexPath.item < self.data.photos.count {
            cell.photoFriend.image = UIImage(named: self.data.photos[indexPath.item])
//            cell.likeButton = LikesButton.init(frame: CGRect(x: 80, y: 160, width: 20, height: 15))   // не хочет инициализороваться кнопка в ячейке
        }
        return cell
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.likeButton.frame = CGRect(x: 80, y: 160, width: 20, height: 15)
//        self.likeButton.backgroundColor = .darkGray
//    }

    // MARK: UICollectionViewDelegate
}
