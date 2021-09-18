//
//  PhotoCollectionViewCell.swift
//  VISTemplate
//
//  Created by Alaa Gaber on 9/18/21.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

    
       @IBOutlet weak var imgLbl: UILabel?
       @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configData(data: Photo){
        imgLbl?.text = data.author
        imgLbl?.textColor = .blue
        
        let url = URL(string: data.download_url)
        imgView.kf.setImage(with: url)
        
        imgView.widthAnchor.constraint(equalToConstant: CGFloat(data.width)).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: CGFloat(200)).isActive = true
        
    }

}
