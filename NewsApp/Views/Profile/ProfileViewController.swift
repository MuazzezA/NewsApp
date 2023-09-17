//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 15.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImage.image = UIImage(named: UserDefaults.standard.string(forKey: "avatar") ?? "no-image")
        avatarCollectionView.delegate = self
        avatarCollectionView.dataSource = self
    }
    


}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as! ProfileAvatarCollectionViewCell
        cell.avatar.image = UIImage(named: "\(indexPath.row + 1)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        avatarImage.image = UIImage(named: "\(indexPath.row + 1)")
        UserDefaults.standard.set("\(indexPath.row + 1)", forKey: "avatar")
    }
    
}
