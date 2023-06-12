//
//  SearchDetailViewModel.swift
//  Lodoos
//
//  Created by Cagla Efendioglu on 10.06.2023.
//

import Foundation

protocol SearchDetailViewModelProtocol {
    var delegate: SearchDetailViewModelDelegate? { get set}
    func loadSearchData()
}

enum SearchDetailOutPut {
    case searchDetailData(SearchDetail)
    case error(String)
}

protocol SearchDetailViewModelDelegate: AnyObject {
    func handleOutPut(output: SearchDetailOutPut)
}

final class SearchDetailViewModel: SearchDetailViewModelProtocol {
    var delegate: SearchDetailViewModelDelegate?
    var service: SearchDetailServiceProtocol?
    var path: String?
    
    init(service: SearchDetailServiceProtocol, path: String) {
        self.service = service
        self.path = path
    }
}

extension SearchDetailViewModel {
    func loadSearchData() {
        guard let path = path else { return }
        service?.fetchAllData(path: path , onSuccess: { [delegate] SearchDetail in
            delegate?.handleOutPut(output: .searchDetailData(SearchDetail))
        }, onError: { [delegate] error in
            delegate?.handleOutPut(output: .error(error))
        })
    }
}
