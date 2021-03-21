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
    
    var loadview = LoadingBar()
    
    @IBOutlet var newstableView: UITableView!
    private var likes = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.title = "News"
        self.navigationItem.titleView?.backgroundColor = .lightGray
        
        newstableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //       self.tableView.addSubview(self.loadview)
        
    }
    
    
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
        
        cell.NewsImageView.addSubview(self.loadview)
        
        self.loadview.frame = CGRect (x: self.view.frame.width / 2, y: cell.NewsImageView.frame.height / 2, width: 48, height: 12)
        
        self.loadview.startAnimation()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let degree : Double = 90
        let roatationAngle = CGFloat(degree * Double.pi / 180)
        let transformCell = CATransform3DMakeRotation(roatationAngle, 0, 1, 0)
        cell.layer.transform = transformCell

        UIView.animate(
            withDuration: 1,
            delay: 0.2,
            options: .curveEaseOut,
            animations:
                {
                    cell.layer.transform = CATransform3DIdentity
                },
            completion:
                { [weak self] _ in
                    self?.loadview.startAnimation()
                }
        )
    }
}
