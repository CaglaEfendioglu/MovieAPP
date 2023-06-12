//
//  NetworkConstant.swift
//  Lodoos
//
//  Created by Cagla Efendioğlu on 2.06.2023.
//

import Foundation

final class NetworkConstant {
    enum SearchListNetwork: String {
        case path_url = "http://www.omdbapi.com/"
        case apikey = "?apikey=badf9c97"
        case search_url = "&s="
        case type_url = "&type=movie"
        
        static func searchListPath(path: String) -> String {
            return "\(path_url.rawValue)\(apikey.rawValue)\(search_url.rawValue)\(path)\(type_url.rawValue)"
        }
    }
    
    enum SearchDetailNetwork: String {
        case path_url = "http://www.omdbapi.com/"
        case apikey = "?apikey=badf9c97"
        case search_url = "&i="
        
        static func searchDetailPath(path: String) -> String {
            return "\(path_url.rawValue)\(apikey.rawValue)\(search_url.rawValue)\(path)"
        }
    }
}
