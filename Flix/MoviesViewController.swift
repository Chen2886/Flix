//
//  MoviesViewController.swift
//  Flix
//
//  Created by Tony Chen on 1/22/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies = [[String:Any]]()
    
    @IBOutlet weak var movieTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieTable.dataSource = self
        self.movieTable.delegate = self
        
        movieTable.rowHeight = UITableView.automaticDimension
        movieTable.estimatedRowHeight = 50
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.movieTable.reloadData()
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let detail = movie["overview"] as! String
        let poster = URL(string: "https://image.tmdb.org/t/p/w185" + (movie["poster_path"] as! String))
        
        cell.titleLabel.text = title
        cell.detailLabel.text = detail
        cell.posterView.af_setImage(withURL: poster!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = movieTable.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let detailVC = segue.destination as! MovieDetailsViewController
        detailVC.movie = movie
        movieTable.deselectRow(at: indexPath, animated: true)
    }
    
}
