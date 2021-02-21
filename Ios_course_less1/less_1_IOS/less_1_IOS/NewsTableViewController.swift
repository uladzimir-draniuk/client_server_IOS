//
//  TableViewController2.swift
//  less_1_IOS
//
//  Created by elf on 04.02.2021.
//

import UIKit

class NewsViewController: UITableViewController {

    
    private var news = [
        News(id: 1, title: "First news is", cntLikes: 112, photo: "news1"),
        News(id: 2, title: "Second news is", cntLikes: 123453, photo: "news2")
    ]
    
    @IBOutlet var newstableView: UITableView!
    private var likes = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.title = "News"
        self.navigationItem.titleView?.backgroundColor = .lightGray
        
       newstableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
       self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    @IBAction func NewsLikeButton(_ sender: Any) {
//        if likes {
//            likes = false
//            self.NewLikeButton.imageView?.image = UIImage(systemName: "heart")
//        } else {
//            self.NewLikeButton.imageView?.image = UIImage(systemName: "heart.fill")
//            likes = true
//        }
//    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell

        cell.NewsImageView.image = UIImage(named: self.news[indexPath.row].photo)
        cell.NewsTitleLabel.text = self.news[indexPath.row].title
        
        if self.news[indexPath.row].cntLikes / 1000 == 0 {
        cell.cntViewsLbl.setTitle("\(self.news[indexPath.row].cntLikes)", for: .normal)
        } else {
            let cnt = self.news[indexPath.row].cntLikes / 1000
            cell.cntViewsLbl.setTitle("\(cnt)" + "k", for: .normal)
        }
        return cell
    }
}
