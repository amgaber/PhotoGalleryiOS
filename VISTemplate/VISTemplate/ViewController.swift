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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCard.delegate = self
        photoCard.dataSource = self
        
        
        photoCard.register(UINib(nibName:"PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"PhotoCollectionViewCell")

      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Do any additional setup after loading the view.
       let request = AF.request("https://picsum.photos/v2/list?page=1&limit=10")
        request.responseDecodable(of: [Photo].self) { (response) in
            guard let photoCards = response.value else { return }
            print("item 1" , photoCards[0].author)
            self.photos = photoCards
            self.photoCard.reloadData()
          }
    }
    
    


}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.configData(data: photos[indexPath.row])
                return cell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
       
        self.imageTapped(imageURL: photos[indexPath.row].download_url )
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

