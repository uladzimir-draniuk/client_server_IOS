//
//  TableViewController1.swift
//  less_1_IOS
//
//  Created by elf on 02.02.2021.
//

import UIKit

class TableViewController1: UITableViewController {

    
    private var friends = [
        Friend(id: 1, name: "Ivan", surname: "Pigov", avatarImage: "pigs", isFriend: true, photos: ["pig_1", "pig_2", "pig_3"]),
        Friend(id: 2, name: "Petr", surname: "Lionov", avatarImage: "lion", isFriend: true, photos: ["lion_1", "lion_2", "lion_3"]),
        Friend(id: 3, name: "Sidor", surname: "Bearnik", avatarImage: "bear", isFriend: true, photos: ["bear_1", "bear_2", "bear_3"])
    ]
    
    private var filteredFriends = [Friend]()
    private var sectionLabels = [String]()
    private var friendForLabels = [[Friend]]()
    
    @IBOutlet var table_item1: UITableView!
    
    func getSorted() -> [Friend] {
        
        self.friends = self.friends.sorted { friend1, friend2 in
            friend1.surname.first! < friend2.surname.first!
        }
        return self.friends
    }
    
    func getLabelForFriend(_ friends : [Friend]) -> [String] {
    
        for friend in friends {
            let firstChar = String(friend.surname.lowercased().first!)
            if self.sectionLabels.isEmpty || self.sectionLabels.last != firstChar {
                self.sectionLabels.append(firstChar)
            }
        }
        return self.sectionLabels
    }
    
    func getFriendsForLable(_ friends : [Friend], _ sectionLabels : [String]) -> [[Friend]] {
           
        self.filteredFriends = friends
        if self.friendForLabels.isEmpty {
            friendForLabels.removeAll()
        }
        for i in 0..<sectionLabels.count {
            self.friendForLabels.append(filteredFriends.filter {
                $0.surname.lowercased().hasPrefix(sectionLabels[i])
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
        
        self.filteredFriends = self.getSorted()
        self.friendForLabels = self.getFriendsForLable(self.friends,getLabelForFriend(self.friends))
        
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionLabels.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        self.friendForLabels[section].removeAll()
        self.friendForLabels[section] = filteredFriends.filter {
            $0.surname.lowercased().hasPrefix(sectionLabels[section])
        }
        return friendForLabels[section].count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
   
        cell.friendName.text = self.friendForLabels[indexPath.section][indexPath.row].surname + " " + self.friendForLabels[indexPath.section][indexPath.row].name
        cell.avatarView.imageView.image = UIImage(named: self.friendForLabels[indexPath.section][indexPath.row].avatarImage)
        
        
        if indexPath.section % 2 == 0
        {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        } else
        {
            cell.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.8)
        }
        

        return cell
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
        
        let vc = segue.destination as? PhotosCollectionViewController
        vc?.data = self.friendForLabels[indexPath.section][indexPath.row]
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionLabels[section].uppercased()
    }
}

extension TableViewController1 : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.friendForLabels.removeAll()
        self.sectionLabels.removeAll()
        
        if searchText.isEmpty {
            
            self.friendForLabels = self.getFriendsForLable(self.friends, getLabelForFriend(self.friends))
            self.table_item1.reloadData()
            
        } else {
            
            self.filteredFriends = self.friends.filter {
                $0.surname.lowercased().contains(searchText.lowercased())
            }
            self.friendForLabels = self.getFriendsForLable(self.filteredFriends,getLabelForFriend(self.filteredFriends))
            self.table_item1.reloadData()
            
        }
    }
    
}

