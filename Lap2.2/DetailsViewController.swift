//
//  DetailsViewController.swift
//  Lap2.2
//
//  Created by MacOSSierra on 2/6/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class DetailsViewController: UIViewController {
    
    
    var movie : MovieOld!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailYear: UILabel!
   // @IBOutlet weak var detailRate: UILabel!
   
    @IBOutlet weak var detailRate: CosmosView!
    
    @IBOutlet weak var detailGener: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailGener.text = String(movie.genre[0] + "" + movie.genre[1])
        detailTitle.text = movie.title
        detailRate.rating = Double(movie.rating)
        detailYear.text = String(movie.releaseYear)
        //detailImage.image = UIImage(named: movie.image)
        
        detailImage.sd_setImage(with: URL(string: movie.image), placeholderImage: UIImage(named: "av1.png"))
        

        // Do any additional setup after loading the view.
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
