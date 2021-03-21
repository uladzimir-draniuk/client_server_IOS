//
//  TableViewController2.swift
//  less_1_IOS
//
//  Created by elf on 04.02.2021.
//

import UIKit

class TableViewController2: UITableViewController {

    
    private var groups = [
        Group(id: 1, name: "animals", avatarImage: "group_1", isMyGroup: true),
        Group(id: 2, name: "cars", avatarImage: "group_2", isMyGroup: true)
    ]
    
    @IBOutlet var table_group: UITableView!
    
    @IBAction func pushBarButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "psubBarButton", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Groups"

        table_group.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCell")
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
   override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        
        cell.groupImage.image = UIImage(named: self.groups[indexPath.row].avatarImage)
        cell.groupName.text = self.groups[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell1 = tableView.cellForRow(at: indexPath) as! GroupTableViewCell
        
        if cell1.groupImage.isHighlighted {
            cell1.groupImage.transform = CGAffineTransform(translationX: -cell1.groupImage.bounds.height/4,
                                                           y: 0)
            
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
                completion: nil
            )
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

