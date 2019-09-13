//
//  TVListDetailCell.swift
//  EBerryTVApp
//
//  Created by Mehmet Can Seyhan on 2019-09-12.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import UIKit

class TvListCell: UITableViewCell {
    
    //MARK: IBOUTLETS
    @IBOutlet var imageViewTv: UIImageView!
    @IBOutlet var lblTvName: UILabel!
    @IBOutlet var lblTvSubTitle: UILabel!
    
    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Configure cell content
    func cellConfiguretion(tvListModel:TvListModel, indexPathRow: Int) {
        lblTvName.text = tvListModel.show?.name ?? ""
        lblTvSubTitle.text = Helper.replaceContent(text: tvListModel.show?.summary) 
        if let imageUrl = tvListModel.show?.image?.medium {
            Helper.imageLoad(imageView: imageViewTv, url: imageUrl)
        }
        
        /*  self.clipsToBounds = true
        self.layer.cornerRadius = 8
         if indexPathRow.isMultiple(of: 2) {
            self.backgroundColor = UIColor.lightGray
        } else {
            self.backgroundColor = UIColor.white
        } */
    }

}
