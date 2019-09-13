//
//  TvListDetailController.swift
//  EBerryTVApp
//
//  Created by Mehmet Can Seyhan on 2019-09-12.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import UIKit

class TvListDetailController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet var imageViewTV: UIImageView!
    @IBOutlet var lblTvDescription: UILabel!
    
    //MARK: VARIABLES
    var lblName:String?
    var imageViewUrl:String?
    var lblDesctiption:String?
    
    //MARK: FUNCS
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setData()
    }
    
    //set data to all views if it isn't empty each variable
    func setData() {
        if let name = lblName {
            title = name
        }
        if let description = lblDesctiption {
            lblTvDescription.text = description
        }
        if let imageUrl = imageViewUrl {
            Helper.imageLoad(imageView: imageViewTV, url: imageUrl)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
