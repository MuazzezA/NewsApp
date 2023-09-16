//
//  SavedNewsViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 15.09.2023.
//

import UIKit

class SavedNewsViewController: UIViewController {

    @IBOutlet weak var savedNewsTableView: UITableView!
    
    let context = appDelegate.persistentContainer.viewContext
    var savedNewsData =  [SavedNews]()

    override func viewDidLoad() {
        super.viewDidLoad()
        savedNewsTableView.dataSource = self
        savedNewsTableView.delegate = self
        
        readNewsDatabase()
        savedNewsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readNewsDatabase()
        savedNewsTableView.reloadData()
    }


    func readNewsDatabase(){
        
        do{
            savedNewsData = try context.fetch(SavedNews.fetchRequest())
        }catch{
            print("hata-okurken ---- ")
        }
        
        for i in savedNewsData{
            print("** title : ", i.title!)
        }
    }
}

