//
//  ViewController.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import UIKit
import SDWebImage

class HomeView: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    var movies =  [MovieModel]()
    
    let homeViewModel = HomeViewModel()
    let identifier = "movieCell"
    
    var choosenMovie = ""
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        searchBar.delegate = self
        
        notFoundLabel.isHidden = true
        
        getMovies(query: "Batman")
    }

    
    private func getMovies(query: String){
        movies.removeAll(keepingCapacity: false)
        guard let urlEncoded = query.addingPercentEncoding(withAllowedCharacters: .alphanumerics) as? String else{
            print("urlEncode Error")
            return
        }
        
        homeViewModel.getSearchMovies(searchText: urlEncoded) { [weak self] result  in
            switch result{
            case .failure(let error):
                print(error)
                if error == MovieError.NotFoundError {
                    DispatchQueue.main.async {
                        self?.moviesTableView.isHidden = true
                        self?.notFoundLabel.isHidden = false
                        self?.moviesTableView.reloadData()
                    }
                }else if error == MovieError.URLError {
                    DispatchQueue.main.async {
                        self?.moviesTableView.isHidden = true
                        self?.notFoundLabel.isHidden = false
                        self?.moviesTableView.reloadData()
                    }
                }
            case .success(let movieArray):
             
                self?.movies = movieArray
                DispatchQueue.main.async {
                    self?.moviesTableView.isHidden = false
                    self?.notFoundLabel.isHidden = true
                    self?.moviesTableView.reloadData()
                }
            }
        }
    }
    
  

}

extension HomeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getMovies(query: searchBar.text!)
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! MovieViewCell
        let movie = movies[indexPath.row]
        cell.movieNameLabel.text = movie.Title
        DispatchQueue.main.async {
            cell.posterImageView.sd_setImage(with: URL(string: movie.Poster))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let titleEncoded = movies[indexPath.row].Title.addingPercentEncoding(withAllowedCharacters: .alphanumerics) as? String else{
            print("urlEncode Error")
            return
        }
        
        self.choosenMovie = titleEncoded
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailView
            
            destinationVC.movieName = choosenMovie
        }
    }
    
}
