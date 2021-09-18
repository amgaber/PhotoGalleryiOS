//
//  ViewController.swift
//  VISTemplate
//
//  Created by Alaa Gaber on 9/17/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    
    @IBOutlet weak var photoCard: UICollectionView!
    var photos:[Photo] = []
    var addvertisments:[SponserAds] = []
    var pageNumber = 1
    var pageLimit = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Relax Mood"
        photoCard.delegate = self
        photoCard.dataSource = self
      
        registerXIBCell()
        registerAdsXIBCell()

      
    }
    
    func registerXIBCell(){
        photoCard.register(UINib(nibName:"PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"PhotoCollectionViewCell")
    }
    
    func registerAdsXIBCell(){
        photoCard.register(UINib(nibName:"AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"AdsCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
       getPhotosList(pageSize: pageNumber, limit: pageLimit)
        
        getAdsList()
    }
    
    func getPhotosList(pageSize: Int, limit: Int){
        let request = AF.request("https://picsum.photos/v2/list?page=\(pageSize)&limit=\(limit)")
         request.responseDecodable(of: [Photo].self) { (response) in
             guard let photoCards = response.value else { return }
             self.photos = photoCards
             self.photoCard.reloadData()
           }
    }
    

    func getAdsList(){
        let requestAds = AF.request("https://picsum.photos/v2/list?page=1&limit=10")
         requestAds.responseDecodable(of: [SponserAds].self) { (response) in
             guard let ads = response.value else { return }
             self.addvertisments = ads
             self.photoCard.reloadData()
           }
    }

}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if addvertisments.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
            cell.configData(data: photos[indexPath.row])
                    return cell
            
         }else{
            let adsIndex = min(5, photos.count )
            if indexPath.row == adsIndex {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCollectionViewCell", for: indexPath) as! AdsCollectionViewCell
                cell.configData(data: addvertisments[indexPath.row])
                  return cell
             
             }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
                cell.configData(data: photos[indexPath.row])
                 return cell
             }
    }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width , height: 400)
            }

            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }

            func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }
        
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            //cause by user
            print("SCROLL scrollViewDidEndDragging")
        }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //caused by user
        
        print("SCROLL scrollViewDidEndDecelerating")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let adsIndex = min(5, photos.count )
        if indexPath.row != adsIndex {
    
        self.imageTapped(imageURL: photos[indexPath.row].download_url )
        }
    }
        
    func imageTapped(imageURL:String){
        let url = URL(string: imageURL)
        let newImageView = UIImageView(image: UIImage())
        newImageView.kf.setImage(with: url)
        
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
}


