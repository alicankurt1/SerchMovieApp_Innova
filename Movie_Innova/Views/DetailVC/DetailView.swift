//
//  DetailView.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import UIKit
import SDWebImage

class DetailView: UIViewController {
    
    let detailViewModel = DetailViewModel()
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    var movieName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if movieName != "" {
            getMovie(movieName: movieName)
        }
        
    }
    
    private func getMovie(movieName: String){
        detailViewModel.getMovieDetail(movieName: movieName) { [weak self] result  in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let movie):

                DispatchQueue.main.async {
                    self?.posterImageView.sd_setImage(with: URL(string: movie.Poster))
                    self?.titleLabel.text = movie.Title
                    self?.yearLabel.text = movie.Year
                    self?.actorLabel.text = movie.Actors
                    self?.placeLabel.text = movie.Country
                    self?.ratingLabel.text = "IMDB rating: \(movie.Ratings![0]["Value"]!)"
                    self?.directorLabel.text = movie.Director
                }
                
                
                
            }
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
