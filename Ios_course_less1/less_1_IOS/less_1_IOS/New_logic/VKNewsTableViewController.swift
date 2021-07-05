//
//  VKNewsTableViewController.swift
//  VKAppClone
//
//  Created by elf on 18.06.2021.
//

import UIKit

protocol AnyNewsCell {
    
}

enum NewsType: CaseIterable {
    case image
    case text
    case source
    case otherInfo
    
    var cellClassIdentifier: String {
        switch self {
        case .image:
            return "NewsImageCell"
        case .otherInfo:
            return "NewsOtherInfoCell"
        case .source:
            return "NewsSourceCell"
        case .text:
            return "NewsTextCell"
        }
    }
}

class VKNewsTableViewController: UITableViewController {

    private var netSession = VKServiceFunc.init(token: Session.shared.token)
    
    private var news: [VKNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "News"

        tableView.register(NewsImageCell.self, forCellReuseIdentifier: "NewsImageCell")
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: "NewsTextCell")
        tableView.register(NewsSourceCell.self, forCellReuseIdentifier: "NewsSourceCell")
        tableView.register(NewsOtherInfoCell.self, forCellReuseIdentifier: "NewsOtherInfoCell")
        
        netSession.loadNews(completionHandler: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(news):
                self?.news = news
                self?.tableView.reloadData()
            }
        })
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NewsType.allCases.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                       
        switch NewsType.allCases[indexPath.row] {
        case .image:
            let cellIdentifier = "NewsImageCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsImageCell else { return UITableViewCell() }
            cell.configure(with: news[indexPath.section])
            return cell
        case .otherInfo:
            let cellIdentifier = "NewsOtherInfoCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsOtherInfoCell else { return UITableViewCell() }
            cell.configure(with: news[indexPath.section])
            return cell
        case .source:
            let cellIdentifier = "NewsSourceCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsSourceCell else { return UITableViewCell() }
            cell.configure(with: news[indexPath.section])
            return cell
        case .text:
            let cellIdentifier = "NewsTextCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTextCell else { return UITableViewCell() }
            cell.configure(with: news[indexPath.section])
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
