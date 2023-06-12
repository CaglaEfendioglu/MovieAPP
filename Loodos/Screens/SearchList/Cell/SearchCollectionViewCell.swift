//
//  SearchCollectionViewCell.swift
//  Lodoos
//
//  Created by Cagla Efendioğlu on 2.06.2023.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
       
       private lazy var SearchName: UILabel = {
           let label = UILabel()
           label.font = .boldSystemFont(ofSize: 15)
           label.numberOfLines = 0
           label.textAlignment = .left
           label.textColor = .black
           contentView.addSubview(label)
           return label
       }()
        
       private lazy var SearchImage: UIImageView = {
           let image = UIImageView()
           image.clipsToBounds = true
           image.backgroundColor = .white
           image.layer.cornerRadius = 8
           contentView.addSubview(image)
           return image
       }()
       
       enum Identifier: String {
           case path = "Cell"
       }
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func configure() {
           contentView.backgroundColor = .white
           contentView.layer.borderWidth = 1
           contentView.layer.borderColor = UIColor.gray.cgColor
           contentView.layer.cornerRadius = 8
           makeImage()
           makeName()
       }
       
       func saveModel(value: Search) {
           let url = URL(string: (value.poster ?? ""))
           SearchImage.kf.setImage(with: url)
           SearchName.text = value.title
       }
   }

   //MARK: - Constraints

   extension SearchCollectionViewCell {
       private func makeImage() {
           SearchImage.snp.makeConstraints { make in
               make
                   .left
                   .equalTo(contentView)
                   .offset(16)
               make
                   .centerY
                   .equalTo(contentView.snp.centerY)
               make
                   .height
                   .equalTo(contentView.frame.size.height / 1.5)
               make
                   .width
                   .equalTo(contentView.frame.size.height / 1.5)
           }
       }
       
       private func makeName() {
           SearchName.snp.makeConstraints { make in
               make.centerY.equalTo(SearchImage.snp.centerY)
               make
                   .left
                   .equalTo(SearchImage.snp.right)
                   .offset(24)
               make
                   .right
                   .equalTo(contentView.snp.right)
                   .offset(-16)
       }
   }
}
