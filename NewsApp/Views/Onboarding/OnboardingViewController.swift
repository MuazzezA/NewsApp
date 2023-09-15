//
//  OnboardingViewController.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 10.09.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var button: UIButton!
    
    var slides:[OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                button.setTitle("Başla", for: .normal)
            }else{
                button.setTitle("Devam Et", for: .normal)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        let onboardingSlide1 = OnboardingSlide(
            title: "Hoş Geldin!",
            description: "İstediğiniz her yerde ve her zaman habere ulaşmak artık daha kolay. İstersen kayıt ettiğin haberlere bile sonra bakabilirsin.",
            image: UIImage(named: "breaking-news")! // Bu kısmı kendi resminiz ile değiştirin
        )

        let onboardingSlide2 = OnboardingSlide(
            title: "Haberleri Keşfedin",
            description: "Son dakika haberleri, güncel gelişmeler, kategorileme ile belli hedefe yönelik haberler daha fazlasını keşfedin.",
            image: UIImage(named: "today-news")! // Bu kısmı kendi resminiz ile değiştirin
        )
        
        let onboardingSlide3 = OnboardingSlide(
            title: "Haydi Başlayalım!",
            description: "Sende 'Dünyadan haberim olsun' diyorsan hesabını oluştur ve güncelliğin keyfini çıkar.",
            image: UIImage(named: "news")! // Bu kısmı kendi resminiz ile değiştirin
        )

        slides.append(onboardingSlide1)
        slides.append(onboardingSlide2)
        slides.append(onboardingSlide3)
        
    }
    

    @IBAction func nextButtonAct(_ sender: Any) {
        
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "authNC" ) as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true, completion: nil)
            
        } else {
            currentPage += 1
            let indexPath = IndexPath (item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true )
        }


    }

}


extension OnboardingViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingcell" , for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(
           width: collectionView.frame.width , height: collectionView.frame .height)
       // bunu kullanmazsan pageControlu çalıştıramıyorsun
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
   
    
}
