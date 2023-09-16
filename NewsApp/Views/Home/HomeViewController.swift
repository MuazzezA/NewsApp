//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 15.09.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class HomeViewController: UIViewController {

    
    @IBOutlet weak var newsTableView: UITableView!
    var topHeadlinesData: News?
    var mainNewsData: News? // burası güncellenebilir data olacak - kategori ve search işlemlerinde yeni datayla güncellenmeli /default topHeadlinesData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        let urlString = "top-headlines?country=us"
        
        WebService.shared.getNewsData(with: urlString) { result in
            switch result {
            case .success(let newsData):
                DispatchQueue.main.async {
                    self.topHeadlinesData = newsData
                    self.mainNewsData = newsData
                    self.newsTableView.reloadData()
                }
            case .failure(let error):
                print("Hata:", error)
            }
        }
    }
}


