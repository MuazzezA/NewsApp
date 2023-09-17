//
//  HomeTableViewExtension.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 16.09.2023.
//
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainNewsData?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
                    
        let article = mainNewsData?.articles[indexPath.row]
       
        cell.newsTitle.text = article?.title
        cell.newsDescription.text = article?.description
        
        if let imageURLString = article?.urlToImage, let imageURL = URL(string: imageURLString) {
            let session = URLSession.shared
            let task = session.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Hata:", error)
                    DispatchQueue.main.async {
                        cell.newsImage.image = UIImage(named: "no-image")
                    }
                } else if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        cell.newsImage.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.newsImage.image = UIImage(named: "no-image")
                    }
                }
            }
            task.resume()
        } else {
            cell.newsImage.image = UIImage(named: "no-image")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = mainNewsData?.articles[indexPath.row]
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let newsDetailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newsDetailVC.newsArticleDetail = selectedArticle
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
   
}

