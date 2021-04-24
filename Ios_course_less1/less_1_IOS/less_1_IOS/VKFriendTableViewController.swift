//
//  VKFriendTableViewController.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//

import UIKit

class VKFriendTableViewController: UITableViewController {

    
    private var friends = [VKFriend]()
    private var photos = [VKPhoto]()
    
    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    private var filteredFriends = [VKFriend]()
    private var sectionLabels = [String]()
    private var friendForLabels = [[VKFriend]]()
    
    @IBOutlet var table_item1: UITableView!
    
    func getSorted(inOut: [VKFriend] ) -> [VKFriend] {
        
        self.friends = inOut.sorted { friend1, friend2 in
            friend1.lastName.first! < friend2.lastName.first!
        }
        return self.friends
    }
    
    func getLabelForFriend(_ friends : [VKFriend]) -> [String] {
        
        self.sectionLabels.removeAll()
        for friend in friends {
            let firstChar = String(friend.lastName.lowercased().first!)
            if self.sectionLabels.isEmpty || self.sectionLabels.last != firstChar {
                self.sectionLabels.append(firstChar)
            }
        }
        return self.sectionLabels
    }
    
    func getFriendsForLable(_ friends : [VKFriend], _ sectionLabels : [String]) -> [[VKFriend]] {
           
        self.filteredFriends = friends
        if !self.friendForLabels.isEmpty {
            friendForLabels.removeAll()
        }
        for i in 0..<sectionLabels.count {
            self.friendForLabels.append(filteredFriends.filter {
                $0.lastName.lowercased().hasPrefix(sectionLabels[i])
            })
        }
        return self.friendForLabels
    }
    
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
        self.filteredFriends = friends
        
  }
    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        netSession.loadFriends(completionHandler: { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                self.friends = friends
                if self.friends.count > 0 {
                    self.filteredFriends = self.getSorted(inOut: self.friends)
                    self.friendForLabels = self.getFriendsForLable(self.friends,self.getLabelForFriend(self.friends))
                    
                }
                self.table_item1.reloadData()
                self.filteredFriends = friends
            }
        })
        
        
        
        
//        self.filteredFriends = friends
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if sectionLabels.count > 0 {
            return sectionLabels.count
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.friendForLabels.count > 0
        {
            self.friendForLabels[section].removeAll()
            self.friendForLabels[section] = filteredFriends.filter {
                $0.lastName.lowercased().hasPrefix(sectionLabels[section])
            }
            return friendForLabels[section].count
            
        } else {
            return 1
        }
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
        
        if self.friendForLabels.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
            
            
            cell.friendName.text = self.friendForLabels[indexPath.section][indexPath.row].lastName + " " + self.friendForLabels[indexPath.section][indexPath.row].firstName
            cell.avatarView.imageView.kf.setImage(with: self.friendForLabels[indexPath.section][indexPath.row].photoUrl)
            
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
        vc?.data = self.friendForLabels[indexPath.section][indexPath.row]
        netSession.loadPics(owner: (vc?.data.id)!, completionHandler: { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(photos):
                self.photos = photos
            }
        })
        vc?.photos = self.photos
        
        
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sectionLabels.count > 0 {
            return sectionLabels[section].uppercased()
        }
        return "1"
    }
}

extension VKFriendTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.friendForLabels.removeAll()
        self.sectionLabels.removeAll()
        
        if searchText.isEmpty {
            
            self.friendForLabels = self.getFriendsForLable(self.friends, getLabelForFriend(self.friends))
            self.table_item1.reloadData()
            
        } else {
            
            self.filteredFriends = self.friends.filter {
                $0.lastName.lowercased().contains(searchText.lowercased())
            }
            self.friendForLabels = self.getFriendsForLable(self.filteredFriends, getLabelForFriend(self.filteredFriends))
            self.table_item1.reloadData()
            
        }
    }
    
}

