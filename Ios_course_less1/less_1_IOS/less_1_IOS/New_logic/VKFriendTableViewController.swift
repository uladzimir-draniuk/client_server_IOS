//
//  VKFriendTableViewController.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//

import UIKit
import RealmSwift

class VKFriendTableViewController: UITableViewController {

    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    private var friends: Results<VKFriend>? = try? RealmAdds.get(type: VKFriend.self)
    
    @IBOutlet var table_item1: UITableView!
    
    var dataForShowed = [VKFriendSection]()
    var sectionedFriends: [VKFriendSection] {
        guard let friends = friends else { return [] }
        return friends.reduce(into: [VKFriendSection]() ) { currentSectionFriends, friend in
            
            guard let firstLetter = friend.lastName.first else { return }
            
            if let currentSectionFriendFirstLetterIndex = currentSectionFriends.firstIndex(where: { $0.title == firstLetter })
            {
                let oldSection = currentSectionFriends[currentSectionFriendFirstLetterIndex]
                let updatedSection = VKFriendSection(title: firstLetter, friends: oldSection.friends + [friend])
                currentSectionFriends[currentSectionFriendFirstLetterIndex] = updatedSection
             } else {
                let newSection = VKFriendSection(title: firstLetter, friends: [friend])
                currentSectionFriends.append(newSection)
            }
         }.sorted()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationItem.title = "Friends"
        
        tableView.backgroundColor = UIColor.yellow
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Friends", style: .plain, target: self, action: nil)
        
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
        
        table_item1.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        table_item1.tableHeaderView = searchBar
        dataForShowed = sectionedFriends
  }

    override func viewWillAppear(_ animated: Bool) {
        netSession.loadFriends(completionHandler: { [self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                try? RealmAdds.save(items: friends, configuration: RealmAdds.deleteIfMigration, update: .all)
                self.dataForShowed = self.sectionedFriends
                self.table_item1.reloadData()
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataForShowed.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            
            cell.friendName.text = dataForShowed[indexPath.section].friends[indexPath.row].lastName + " " + dataForShowed[indexPath.section].friends[indexPath.row].firstName
            cell.avatarView.imageView.kf.setImage(with: dataForShowed[indexPath.section].friends[indexPath.row].photoUrl)
            
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
        
        guard let indexPath = currIndex, segue.identifier == "showCollection" else { return }
        
        let vc = segue.destination as? VKFriendPhotosCollectionViewController
        vc?.data = dataForShowed[indexPath.section].friends[indexPath.row]
    }
}

extension VKFriendTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       dataForShowed.removeAll()
       
        if searchText.isEmpty {
            dataForShowed = sectionedFriends
        } else {
            for section in sectionedFriends {
                let sortedFriends = section.friends.filter ({$0.lastName.lowercased().contains(searchText.lowercased())})
                               
                if sortedFriends.isEmpty {
                    continue
                } else {
                    dataForShowed.append ( VKFriendSection.init( title: section.title, friends: sortedFriends))
                }
            }
        }
        table_item1.reloadData()
    }
}
    


