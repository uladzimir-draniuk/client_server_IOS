//
//  VKGroupTableViewController.swift
//  VKAppClone
//
//  Created by elf on 10.05.2021.
//

import UIKit
import Kingfisher

class VKGroupTableViewController: UITableViewController {

    private var groups = [VKGroup]()
    
    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    @IBOutlet var table_group: UITableView!
    
    @IBAction func pushBarButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "psubBarButton", sender: self)
    }
    
    func getSorted(inOut: [VKGroup] ) -> [VKGroup] {
        
        self.groups = inOut.sorted { group1, group2 in
            guard let firstCharacter1 = group1.name.first,
                  let firstCharacter2 = group2.name.first else { return true }
            return firstCharacter1 < firstCharacter2
        }
        return self.groups
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

    override func viewWillAppear(_ animated: Bool) {
        self.groups.removeAll()
        netSession.loadGroup(completionHandler: { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(groups):
                self.groups = self.getSorted(inOut: groups)
            }
            self.table_group.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell

        cell.groupImage.kf.setImage(with: self.groups[indexPath.row].photoUrl)
        cell.groupName.text = self.groups[indexPath.row].name

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
                        self.performSegue(withIdentifier: "ShowMyGroup", sender: self)
                    }
            )
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "ShowMyGroup" else { return }
        guard let destination = segue.destination as? VKGroupViewController else { return }
        
        guard let indexPath = self.currIndex else { return }
        destination.group = self.groups[indexPath.row]
        destination.modalPresentationStyle = .automatic
    }
}
