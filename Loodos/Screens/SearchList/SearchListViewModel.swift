//
//  SearchListViewModel.swift
//  Lodoos
//
//  Created by Cagla Efendioğlu on 2.06.2023.
//

import Foundation

protocol SearchLitViewModelProtocol {
    var delegate: SearchLitViewModelDelegate? { get set}
    func load(path: String)
}

enum SearchListOutPut {
    case searchList([Search])
    case error(String)
    case isLoading(Bool)
}

protocol SearchLitViewModelDelegate {
    func handleOutPut(output: SearchListOutPut)
}

final class SearchLitViewModel: SearchLitViewModelProtocol {
    var delegate: SearchLitViewModelDelegate?
    var service: SearchListServiceProtocol?
    
    init(service: SearchListServiceProtocol) {
        self.service = service
    }
}

extension SearchLitViewModel {
    func load(path: String) {
        delegate?.handleOutPut(output: .isLoading(true))
        service?.fetchAllData(path: path, onSuccess: { [delegate] searchData in
            delegate?.handleOutPut(output: .isLoading(false))
            delegate?.handleOutPut(output: .searchList(searchData))
        }, onError: { [delegate] error in
            delegate?.handleOutPut(output: .isLoading(false))
            delegate?.handleOutPut(output: .error(error))
        })
    }
}
