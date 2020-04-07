//
//  MainViewController.swift
//  rss_client
//
//  Created by temir on 03.04.2020.
//  Copyright © 2020 temir. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
    func success()
    func failure()
}

class MainViewController: UIViewController {
    
    weak var presenter: MainViewPresenterProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var articles: [Article] {
        if let result = presenter?.articles {
            return result
        } else {
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        // Do any additional setup after loading the view.
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as? ArticlesTableCell else {
            return UITableViewCell()
        }
        
        cell.setArticle(articles[indexPath.row])
        return cell
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        print(articles.first?.title ?? "fail")
    }
    
    func failure() {
        
    }
}
