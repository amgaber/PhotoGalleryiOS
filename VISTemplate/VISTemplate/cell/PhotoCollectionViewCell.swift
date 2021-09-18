//
//  PhotoCollectionViewCell.swift
//  VISTemplate
//
//  Created by Alaa Gaber on 9/18/21.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

        @IBOutlet weak var bgView: UIView!
       @IBOutlet weak var imgLbl: UILabel?
       @IBOutlet weak var imgView: UIImageView!
    
    func configData(data: Photo){
        bgView.layer.cornerRadius = 10
        imgLbl?.text = data.author
        imgLbl?.textColor = .blue
        
        let url = URL(string: data.download_url)
        imgView.kf.setImage(with: url)
        
        imgView.widthAnchor.constraint(equalToConstant: CGFloat(data.width)).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: CGFloat(200)).isActive = true
        
    }

}
