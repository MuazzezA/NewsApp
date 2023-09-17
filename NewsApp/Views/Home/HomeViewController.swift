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

    
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var homeTitleLabel: UILabel!
    
    var topHeadlinesData: News?
    var mainNewsData: News? // burası güncellenebilir data olacak - kategori ve search işlemlerinde yeni datayla güncellenmeli /default topHeadlinesData
    
    var sideMenu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        searchBar.delegate = self
        
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
    
    @IBAction func buttonTapped(_ sender: UIButton) {
       
        if let title = sender.titleLabel?.text {
            let trimmedLowercasedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            print("button title : \(trimmedLowercasedTitle)")
            fetchNewsForCategories(category: trimmedLowercasedTitle)
            homeTitleLabel.text = title
        }
        
    }
    
    @IBAction func menuButtonAct(_ sender: Any) {
        sideMenu ? closeSideMenu() : openSideMenu()
    }
    func openSideMenu(){
        leadingConst.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        })
        sideMenu = !sideMenu
    }
    
    func closeSideMenu(){
        leadingConst.constant = -250
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        })
        sideMenu = !sideMenu
    }
    
    func fetchNewsForCategories(category: String){
        print("selected category: ",category)
  
        if(category == "all"){
            print("tüm data")
            self.mainNewsData = self.topHeadlinesData
            self.newsTableView.reloadData()
        }
        else{
            print("kategorili data")
            let urlString = "top-headlines?country=us&category=\(category)"
            WebService.shared.getNewsData(with: urlString) { result in
                switch result {
                case .success(let newsData):
                    DispatchQueue.main.async {
                        self.mainNewsData = newsData
                        self.newsTableView.reloadData()
                    }
                case .failure(let error):
                    print("Hata:", error)
                }
            }
            
        }
        
        closeSideMenu()
    }
}


extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let searchText = searchBar.text {
                if(searchText == ""){
                    self.mainNewsData = self.topHeadlinesData
                    self.newsTableView.reloadData()
                }else{
                    let urlString = "everything?q=\(searchText)"
                    
                    WebService.shared.getNewsData(with: urlString) { result in
                        switch result {
                        case .success(let newsData):
                            DispatchQueue.main.async {
                                self.mainNewsData = newsData
                                self.newsTableView.reloadData()
                            }
                        case .failure(let error):
                            print("Hata:", error)
                        }
                    }
                }
            }
        }
}
