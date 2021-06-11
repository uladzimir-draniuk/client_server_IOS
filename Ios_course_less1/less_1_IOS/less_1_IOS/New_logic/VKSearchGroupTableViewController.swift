//
//  VKSearchGroupTableViewController.swift
//  VKAppClone
//
//  Created by elf on 10.05.2021.
//

import UIKit

class VKSearchGroupTableViewController: UITableViewController {

    private var searchGroups = [VKGroup]()
    
    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    @IBOutlet var table_group: UITableView!
    
    @IBAction func pushBarButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "psubBarButton", sender: self)
    }
    
    func getSorted(inOut: [VKGroup] ) -> [VKGroup] {
        
        self.searchGroups = inOut.sorted { group1, group2 in
            guard let firstCharacter1 = group1.name.first,
                  let firstCharacter2 = group2.name.first else { return true }
            return firstCharacter1 < firstCharacter2
        }
        return self.searchGroups
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search Groups"

        table_group.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCell")
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let searchBar = UISearchBar(
            frame: CGRect(
                origin: .zero,
                size:  CGSize(
                    width: UIScreen.main.bounds.width,
                    height: 50
                    )
                )
            )
        
        self.table_group.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        self.table_group.tableHeaderView = searchBar
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return searchGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell

        cell.groupImage.kf.setImage(with: self.searchGroups[indexPath.row].photoUrl)
        cell.groupName.text = self.searchGroups[indexPath.row].name

        return cell
    }
 
    var currIndex: IndexPath?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell1 = tableView.cellForRow(at: indexPath) as! GroupTableViewCell
        
        if cell1.groupImage.isHighlighted {
            cell1.groupImage.transform = CGAffineTransform(translationX: 0,
                                                           y: -cell1.groupImage.bounds.height/4)
            
            UIView.animate(
                withDuration: 0.6,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0,
                options: .curveEaseOut,
                animations:
                {
                    cell1.groupImage.transform = .identity
                },
                completion:
                    {_ in
                        tableView.deselectRow(at: indexPath, animated: true)
                        self.currIndex = indexPath
                        self.performSegue(withIdentifier: "ShowGroupView", sender: self)
                    }
            )
        }
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "ShowGroupView" else { return }
        guard let destination = segue.destination as? VKGroupViewController else { return }
        
        guard let indexPath = self.currIndex else { return }
        destination.group = self.searchGroups[indexPath.row]
    }
    
}

extension VKSearchGroupTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchGroups.removeAll()
        
        if searchText.isEmpty {
            self.table_group.reloadData()
        } else {
            netSession.searchGroup(group: searchText, completionHandler: { result in
                switch result {
                case let .failure(error):
                    print(error)
                    self.table_group.reloadData()
                case let .success(searchGroups):
                    self.searchGroups = self.getSorted(inOut: searchGroups)
                    self.table_group.reloadData()
                }
            })
        }
    }
}


