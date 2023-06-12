//
//  SearchDetailConstant.swift
//  Lodoos
//
//  Created by Cagla Efendioglu on 10.06.2023.
//

import Foundation

final class SearchDetailConstant {
    enum MovieDetailIMDBUrl: String {
        case basic_url =  "https://www.imdb.com/"
        case path_url =  "title/"
        
        static func pathIMDB(id: String) -> String {
            return "\(basic_url.rawValue)\(path_url.rawValue)\(id)"
        }
    }
    
    enum IMDBButtonTitle: String {
        case titleIMDB = "IMDb Address"
    }
    
    enum PropertyLabel: String {
        case name = "Person Name"
        case gender = "Gender"
        case birthday = "Birthday"
        case description = "Description"
        case unknown = "Unknown"
        case male = "Male"
        case female = "Female"
    }
    
    enum profileImage: String {
        case basic_url =   "https://image.tmdb.org/t/p/"
        case path_url =  "original"
        
        static func pathImage(path: String) -> String {
            return "\(basic_url.rawValue)\(path_url.rawValue)\(path)"
        }
    }
}
