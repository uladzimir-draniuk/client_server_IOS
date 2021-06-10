//
//  VKFriendTableViewController.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//

import UIKit
import RealmSwift

class VKFriendTableViewController: UITableViewController {

    
//    private var friends = [VKFriend]()
    private var photos = [VKPhoto]()
    
    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    private var friends: Results<VKFriend>? = try? RealmAdds.get(type: VKFriend.self)
    
//   private var filteredFriends = [VKFriend]()
 //   private var sectionLabels = [String]()
//   private var friendForLabels = [[VKFriend]]()
    
    @IBOutlet var table_item1: UITableView!
    
    var dataForShowed = [VKFriendSection]()
    var sectionedFriends: [VKFriendSection] {
        guard let friends = friends else { return [] }
        return friends.reduce(into: [VKFriendSection]() ) {
            currentSectionFriends, friend in
            guard let firstLetter = friend.lastName.first else { return }
            
            if let currentSectionFriendFirstLetterIndex = currentSectionFriends.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionFriends[currentSectionFriendFirstLetterIndex]
                let updatedSection = VKFriendSection(title: firstLetter, friends: oldSection.friends + [friend])
                currentSectionFriends[currentSectionFriendFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = VKFriendSection(title: firstLetter, friends: [friend])
                currentSectionFriends.append(newSection)
            }
        }.sorted()
    }
    
//    func getSorted(inOut: [VKFriend] ) -> [VKFriend] {
//
//        self.friends = inOut.sorted { friend1, friend2 in
//            guard let firstCharacter1 = friend1.lastName.first,
//                  let firstCharacter2 = friend2.lastName.first else { return true }
//            return firstCharacter1 < firstCharacter2
//        }
//        return self.friends
//    }
//
//    func getLabelForFriend(_ friends : [VKFriend]) -> [String] {
//
//        self.sectionLabels.removeAll()
//        for friend in friends {
//            let firstChar = String(friend.lastName.lowercased().first!)
//            if self.sectionLabels.isEmpty || self.sectionLabels.last != firstChar {
//                self.sectionLabels.append(firstChar)
//            }
//        }
//        return self.sectionLabels
//    }
//
//    func getFriendsForLable(_ friends : [VKFriend], _ sectionLabels : [String]) -> [[VKFriend]] {
//
//        self.filteredFriends = friends
//        if !self.friendForLabels.isEmpty {
//            friendForLabels.removeAll()
//        }
//        for i in 0..<sectionLabels.count {
//            self.friendForLabels.append(filteredFriends.filter {
//                $0.lastName.lowercased().hasPrefix(sectionLabels[i])
//            })
//        }
//        return self.friendForLabels
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.title = "Friends"
        
        self.tableView.backgroundColor = UIColor.yellow
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Friends", style: .plain, target: self, action: nil)
        
        table_item1.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
        
       
        let searchBar = UISearchBar(
            frame: CGRect(
                origin: .zero,
                size:  CGSize(
                    width: UIScreen.main.bounds.width,
                    height: 50
                    )
                )
            )
        
        self.table_item1.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        self.table_item1.tableHeaderView = searchBar
//        table_item1.dataSource = self
//        table_item1.delegate = self
        dataForShowed = sectionedFriends
        
  }
    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        netSession.loadFriends(completionHandler: { [self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                try? RealmAdds.save(items: friends, configuration: RealmAdds.deleteIfMigration, update: .modified)

//                self.friends = friends
//                if self.friends.count > 0 {
//                    let friendsWithoutDeleted = self.friends.filter {
//                        !$0.firstName.isEmpty && !$0.lastName.isEmpty
//                    }
//                    self.filteredFriends = self.getSorted(inOut: friendsWithoutDeleted)
//                    self.friendForLabels = self.getFriendsForLable(self.friends,self.getLabelForFriend(self.friends))
//
//                }
                self.dataForShowed = self.sectionedFriends
                self.table_item1.reloadData()
 //               self.filteredFriends = friends
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataForShowed.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataForShowed[section].friends.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section % 2 == 0 {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        } else {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.8)
        }
        let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = UIColor.red
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.dataForShowed.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
            
            cell.friendName.text = self.dataForShowed[indexPath.section].friends[indexPath.row].lastName + " " + self.dataForShowed[indexPath.section].friends[indexPath.row].firstName
            cell.avatarView.imageView.kf.setImage(with: self.dataForShowed[indexPath.section].friends[indexPath.row].photoUrl)
            
            if indexPath.section % 2 == 0
            {
                cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
            } else
            {
                cell.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.8)
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataForShowed[section].title.uppercased()
    }
  
    var currIndex: IndexPath?

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell1 = tableView.cellForRow(at: indexPath) as! FriendTableViewCell
        
        if cell1.avatarView.imageView.isHighlighted {
            cell1.avatarView.transform = CGAffineTransform(translationX: 0,
                                                           y: -cell1.avatarView.bounds.height/4)
            
            UIView.animate(
                withDuration: 0.6,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0,
                options: .curveEaseOut,
                animations:
                {
                    cell1.avatarView.transform = .identity
                },
                completion:
                    {_ in
                        tableView.deselectRow(at: indexPath, animated: true)
                        self.currIndex = indexPath
                        self.performSegue(withIdentifier: "showCollection", sender: self)
                    }
            )
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let indexPath = self.currIndex, segue.identifier == "showCollection" else { return }
        
        let vc = segue.destination as? VKFriendPhotosCollectionViewController
        vc?.data = self.dataForShowed[indexPath.section].friends[indexPath.row]
//        vc?.photos = self.photos
    }

}

extension VKFriendTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       self.dataForShowed.removeAll()

        
        
        if searchText.isEmpty {
            self.dataForShowed = sectionedFriends
            self.table_item1.reloadData()
            
        } else {
            for section in sectionedFriends {
                var sortedFriends = section.friends.filter ({$0.lastName.lowercased().contains(searchText.lowercased())})
                               
                if sortedFriends.isEmpty {
                    continue
                } else {
                    self.dataForShowed.append ( VKFriendSection.init(
                                                title: section.title,
                                                friends: sortedFriends)
                    )
                }
            }
            self.table_item1.reloadData()
            
        }
    }
}
    


