//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 16.09.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var newsArticleDetail: Article?
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var starButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedArticle = newsArticleDetail {
            titleLabel.text = selectedArticle.title
            descLabel.text = selectedArticle.description ?? "Açıklama Yok"
            authorLabel.text = selectedArticle.author ?? "Yazar Bilgisi Yok"

            // Eğer imageURLString ve imageURL oluşturulabilirse, resmi yükle
            if let imageURLString = selectedArticle.urlToImage, let imageURL = URL(string: imageURLString) {
                activityIndicator.startAnimating()
                let session = URLSession.shared
                let task = session.dataTask(with: imageURL) { (data, response, error) in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    if let error = error {
                        print("Hata:", error)
                        DispatchQueue.main.async {
                            self.newsImage.image = UIImage(named: "bg-world")
                        }
                    } else if let imageData = data, let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.newsImage.image = image
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.newsImage.image = UIImage(named: "bg-world")
                        }
                    }
                }
                task.resume()
            } else {
                newsImage.image = UIImage(named: "bg-world")
            }
        } else {
            titleLabel.text = "Veri Bekleniyor"
            descLabel.text = ""
            authorLabel.text = ""
            newsImage.image = UIImage(named: "bg-world")
            activityIndicator.startAnimating()
        }
    }
    
    @IBAction func starButtonAct(_ sender: Any) {
        if let button = sender as? UIButton {
            if button.currentImage == UIImage(systemName: "star") {
                button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                button.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    

}
