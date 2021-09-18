//
//  AdsCollectionViewCell.swift
//  VISTemplate
//
//  Created by Alaa Gaber on 9/18/21.
//

import UIKit
import Kingfisher

class AdsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var  adsTitle: UILabel!

    
    func configData(data: SponserAds){
        self.isSelected = false
        bgView.layer.cornerRadius = 20
        bgView.backgroundColor = .red
        
        adsTitle.text = "We will come soon :) "
        
    }

}
