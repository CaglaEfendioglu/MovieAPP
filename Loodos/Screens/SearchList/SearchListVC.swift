//
//  SearchListVC.swift
//  Lodoos
//
//  Created by Cagla Efendioğlu on 2.06.2023.
//

import UIKit
import Lottie

class SearchListVC: UIViewController {

    //MARK: - Views
    
    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "145072-movie-loading")
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
        return animationView
    }()
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    private  var movieSearchBar: UISearchController = {
        let search = UISearchController()
        search.searchBar.placeholder = "Let's find a movie!"
        search.searchBar.showsCancelButton = true
        return search
    }()
    
    private let movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchCollectionViewCell.Identifier.path.rawValue
        )
        return collectionView
    }()
    
    //MARK: - Properties
    
    private var searchData: [Search] = []
    
    var viewModel: SearchLitViewModelProtocol?
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
        viewModel?.delegate = self
        movieSearchBar.searchBar.delegate = self
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        configure()
    }
    
    private func configure() {
        self.title = "Search Movie"
        loadingIndicator.color = .red
        navigationItem.searchController = movieSearchBar
        movieSearchBar.searchBar.sizeToFit()
        view.backgroundColor = .white
        view.addSubview(loadingIndicator)
        view.addSubview(movieCollectionView)
        view.addSubview(animationView)
        
        makeConstraints()
    }
}

//MARK: UISearchBarDelegate

extension SearchListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let textTwo = text.replacingOccurrences(of: " ", with: "+")
        viewModel?.load(path: textTwo)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchData.removeAll()
        animationView.isHidden = false
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
}

//MARK: - SearchLitViewModelDelegate

extension SearchListVC: SearchLitViewModelDelegate {
    func handleOutPut(output: SearchListOutPut) {
        switch output {
        case .searchList(let search):
                searchData = search
                animationView.isHidden = true
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
            
        case .error(let error):
            let errorAlert = UIAlertController(title: "UPS!",
                                               message: "Movie not found.",
                                               preferredStyle: .alert
            )
            let errorAction = UIAlertAction(title: "OK",
                                            style: .cancel
            )
            errorAlert.addAction(errorAction)
            self.present(errorAlert, animated: true)
        case .isLoading(let loading):
                movieCollectionView.isHidden = loading
            loading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension SearchListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? SearchCollectionViewCell else {
                   return UICollectionViewCell()
               }
        
        cell.saveModel(value: searchData[indexPath.row])
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let colums: CGFloat = 1
           let with = collectionView.bounds.width
           let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
           flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
           flowLayout.minimumInteritemSpacing = 20
           flowLayout.minimumLineSpacing = 30
           let width = (with - 20) / colums
           let height = width / 2
           return CGSize(width: width, height: height)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = searchData[indexPath.row].imdbID ?? ""
        let vc = UINavigationController(rootViewController: SearchDetailBuilder.make(path: selectedData))
        self.show(vc, sender: nil)
    }
}


//MARK: - Constraints

extension SearchListVC {
    func makeConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.height.equalTo(view.frame.height * 0.3)
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        animationView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.height.width.equalTo(UIScreen.main.bounds.width * 0.3)
        }
    }
}
