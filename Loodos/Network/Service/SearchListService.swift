//
//  SearchListService.swift
//  Lodoos
//
//  Created by Cagla Efendioğlu on 2.06.2023.
//

import Foundation
import Alamofire

protocol SearchListServiceProtocol {
    func fetchAllData(
        path: String,
        onSuccess: @escaping ([Search]) -> Void,
        onError: @escaping (String) -> Void
         )
}

class SearchListService: SearchListServiceProtocol {
    func fetchAllData(path: String, onSuccess: @escaping ([Search]) -> Void, onError: @escaping (String) -> Void) {
        AF.request(NetworkConstant.SearchListNetwork.searchListPath(path: path), method: .get).responseDecodable(of: SearchResult.self) { movie in
            guard let data = movie.value else {
                return onError("error")
            }
            if let dataTwo = data.search {
                onSuccess(dataTwo)
            }else{
                onError("error")
            }
        }
    }
}
