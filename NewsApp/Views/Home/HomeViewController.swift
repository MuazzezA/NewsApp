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
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ba2891a7f7bf4d06ad781699425b140d"
        
        WebService.shared.getNewsData(with: urlString) { result in
            switch result {
            case .success(let newsData):
                
                DispatchQueue.main.async {
                    
                    //self.topHeadlinesData.removeAll()
                    self.topHeadlinesData = newsData
                    self.newsTableView.reloadData()
                   
                }
            case .failure(let error):
                // Hata durumu
                print("Hata:", error)
            }
        }
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count : ", topHeadlinesData?.articles.count as Any)
        
        return topHeadlinesData?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
                    
        let article = topHeadlinesData?.articles[indexPath.row]
       
        cell.newsTitle.text = article?.title
        cell.newsDescription.text = article?.description
        
        if let imageURLString = article?.urlToImage, let imageURL = URL(string: imageURLString) {
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    cell.newsImage.image = image
                } else {
                    // UIImage oluşturulamadıysa, varsayılan bir resim veya hata işleme ekleyebilirsiniz
                    cell.newsImage.image = UIImage(named: "bg-world")
                }
            } else {
                // Veri alınamadıysa, varsayılan bir resim veya hata işleme ekleyebilirsiniz
                cell.newsImage.image = UIImage(named: "bg-world")
            }
        } else {
            // URL geçerli değilse, varsayılan bir resim veya hata işleme ekleyebilirsiniz
            cell.newsImage.image = UIImage(named: "bg-world")
        }
        
        return cell
    }
    
    
    
}
