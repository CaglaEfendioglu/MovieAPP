//
//  SearchDetailVC.swift
//  Lodoos
//
//  Created by Cagla Efendioglu on 10.06.2023.
//

import UIKit
import FirebaseAnalytics
import Kingfisher

class SearchDetailVC: UIViewController {
    
    //MARK: - Views
    
    private lazy var parentScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: 0 , height: view.frame.height)
        return scroll
    }()
    
    private let parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .lastBaseline
        stackView.spacing = 8
        return stackView
    }()
    
    private var movieImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private var movieGenre: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private var movieYear: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var movieDirector: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var movieWriter: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var movieActor: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var movieRuntime: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private var moviePlot: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private lazy var movieIMDbButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(SearchDetailConstant.IMDBButtonTitle.titleIMDB.rawValue, for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.337, green: 0.745, blue: 0.514, alpha: 1).cgColor
        button.layer.cornerRadius = 9
        return button
    }()
    
    //MARK: - Properties
    
    var searchVievModel: SearchDetailViewModelProtocol?
    var searchData: SearchDetail?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        searchVievModel?.loadSearchData()
        goToIMDB()
    }
    
    private func initDelegate() {
        searchVievModel?.delegate = self
        
        configure()
    }

    private func configure() {
        view.backgroundColor = .white
       
        view.addSubview(parentScrollView)
        parentScrollView.addSubview(parentStackView)
        parentStackView.addArrangedSubview(movieImage)
        parentStackView.addArrangedSubview(movieName)
        parentStackView.addArrangedSubview(movieGenre)
        parentStackView.addArrangedSubview(movieYear)
        parentStackView.addArrangedSubview(movieDirector)
        parentStackView.addArrangedSubview(movieWriter)
        parentStackView.addArrangedSubview(movieActor)
        parentStackView.addArrangedSubview(movieRuntime)
        parentStackView.addArrangedSubview(moviePlot)
        parentStackView.addArrangedSubview(movieIMDbButton)
        
        makeScroll()
        makeStack()
        makeIMDbButton()
        makeImage()
    }
    
    private func propertyUI(search: SearchDetail) {
        movieName.text = "Name: \(search.title ?? "")"
        movieGenre.text = "Genre: \(search.genre ?? "")"
        movieYear.text = "Year: \(search.released ?? "")"
        movieDirector.text = "Director: \(search.director ?? "")"
        movieWriter.text = "Writer: \(search.writer ?? "")"
        movieActor.text = "Actor: \(search.actors ?? "")"
        movieRuntime.text = "Runtime: \(search.runtime ?? "")"
        moviePlot.text = "Info:\n\(search.plot ?? "")"
        let url = URL(string: (search.poster ?? ""))
        movieImage.kf.setImage(with: url)
    }
    
    private func goToIMDB() {
        movieIMDbButton.addTarget(self, action: #selector(clickIMDBUrl), for: .touchUpInside)
    }
    
    @objc func clickIMDBUrl(){
        guard let urlTwo = searchData?.imdbID else { return }
        let url = SearchDetailConstant.MovieDetailIMDBUrl.pathIMDB(id: urlTwo)
        if let url = URL(string: "\(url)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

//MARK: - SearchDetailViewModelDelegate

extension SearchDetailVC: SearchDetailViewModelDelegate {
    func handleOutPut(output: SearchDetailOutPut) {
        switch output {
        case .searchDetailData(let search):
            self.searchData = search
            propertyUI(search: search)
        case .error(let error):
            print(error)
        }
    }
}

//MARK: - Constraints

extension SearchDetailVC {
    private func makeScroll() {
        parentScrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.right.equalTo(-8)
            make.left.equalTo(8)
            make.width.equalTo(view.frame.size.width)
        }
    }
    
    private func makeStack() {
        parentStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(parentScrollView)
            make.width.equalTo(parentScrollView.snp.width)
        }
    }
    
    private func makeIMDbButton() {
        movieIMDbButton.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 15)
            make.width.equalTo(view.frame.size.width / 2)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func makeImage() {
        movieImage.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.frame.size.width / 1.1)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
