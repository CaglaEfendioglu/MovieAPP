//
//  SearchDetailService.swift
//  Lodoos
//
//  Created by Cagla Efendioglu on 11.06.2023.
//

import Foundation
import Alamofire

protocol SearchDetailServiceProtocol {
    func fetchAllData(
        path: String,
        onSuccess: @escaping (SearchDetail) -> Void,
        onError: @escaping (String) -> Void
         )
}

class SearchDetailService: SearchDetailServiceProtocol {
    func fetchAllData(path: String, onSuccess: @escaping (SearchDetail) -> Void, onError: @escaping (String) -> Void) {
        print(NetworkConstant.SearchDetailNetwork.searchDetailPath(path: path))
        AF.request(NetworkConstant.SearchDetailNetwork.searchDetailPath(path: path), method: .get).responseDecodable(of: SearchDetail.self) { movieDetail in
            guard let data = movieDetail.value else {
                return onError("error")
            }
            onSuccess(data)
        }
    }
}
