//
//  VKGroupTableViewController.swift
//  VKAppClone
//
//  Created by elf on 10.05.2021.
//

import UIKit
import Kingfisher
import RealmSwift

class VKGroupTableViewController: UITableViewController {
    
 private var groups: Results<VKGroup>? = try? RealmAdds.get(type: VKGroup.self)

    var showedGroups = [VKGroup]()
    
    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    @IBOutlet var table_group: UITableView!
    
    private var notification: NotificationToken?
    
    @IBAction func pushBarButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "psubBarButton", sender: self)
    }
    
    
    var sectionedGroups: [GroupSection] {
        showedGroups.reduce(into: []) {
            currentSectionGroups, group in
            guard let firstLetter = group.name.first else { return }
            
            if let currentSectionGroupFirstLetterIndex = currentSectionGroups.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionGroups[currentSectionGroupFirstLetterIndex]
                let updatedSection = GroupSection(title: firstLetter, groups: oldSection.groups + [group])
                currentSectionGroups[currentSectionGroupFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = GroupSection(title: firstLetter, groups: [group])
                currentSectionGroups.append(newSection)
            }
        }.sorted()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Groups"

        table_group.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCell")
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.notification = groups?.observe({  [weak self] change in
            guard let self = self else { return}
            switch change {
            case .initial:
                break
            case let .update(results, deletions, insertions, modifications):
                self.table_group.reloadData()
            case let .error(error):
                print(error)
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        showedGroups.removeAll()
        
        netSession.loadGroup(completionHandler: { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(groups):
                self.showedGroups = groups
                try? RealmAdds.save(items: groups, configuration: RealmAdds.deleteIfMigration, update: .modified)
                self.table_group.reloadData()
            }
         })
    }
    
    deinit {
        notification?.invalidate()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
         return sectionedGroups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return sectionedGroups[section].groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
        
        cell.groupImage.kf.setImage(with: sectionedGroups[indexPath.section].groups[indexPath.row].photoUrl)
        cell.groupName.text = sectionedGroups[indexPath.section].groups[indexPath.row].name
        
        if indexPath.section % 2 == 0
        {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        } else
        {
            cell.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.8)
        }
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
                    { cell1.groupImage.transform = .identity },
                completion:
                    {_ in
                        tableView.deselectRow(at: indexPath, animated: true)
                        self.currIndex = indexPath
                        self.performSegue(withIdentifier: "ShowMyGroup", sender: self)
                    }
            )
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionedGroups[section].title.uppercased()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "ShowMyGroup" else { return }
        guard let destination = segue.destination as? VKGroupViewController else { return }
        
        guard let indexPath = self.currIndex else { return }
        destination.group = sectionedGroups[indexPath.section].groups[indexPath.row]
        destination.modalPresentationStyle = .automatic
    }
}
