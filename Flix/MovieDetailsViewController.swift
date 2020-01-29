//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Tony Chen on 1/27/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    var movie: [String:Any]!
    
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        detailLabel.text = movie["overview"] as? String
        let poster = URL(string: "https://image.tmdb.org/t/p/w185" + (movie["poster_path"] as! String))
        let posterBig = movie["backdrop_path"] as? String
        posterImage.af_setImage(withURL: poster!)
        backDropImage.af_setImage(withURL: (URL(string: "https://image.tmdb.org/t/p/original" + posterBig!)!))
        

        
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
