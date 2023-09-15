//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 15.09.2023.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var newsTableView: UITableView!
    var topHeadlinesData: News?
    
    
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
                    self.newsTableView.reloadData()
                   
                }
            case .failure(let error):
                print("Hata:", error)
            }
        }
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topHeadlinesData?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
                    
        let article = topHeadlinesData?.articles[indexPath.row]
       
        cell.newsTitle.text = article?.title
        cell.newsDescription.text = article?.description
        
        if let imageURLString = article?.urlToImage, let imageURL = URL(string: imageURLString) {
            let session = URLSession.shared
            let task = session.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Hata:", error)
                    DispatchQueue.main.async {
                        cell.newsImage.image = UIImage(named: "bg-world")
                    }
                } else if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        cell.newsImage.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.newsImage.image = UIImage(named: "bg-world")
                    }
                }
            }
            task.resume()
        } else {
            cell.newsImage.image = UIImage(named: "bg-world")
        }

        
        return cell
    }
    
    
    
}
