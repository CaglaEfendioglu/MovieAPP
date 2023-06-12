//
//  SearchDetailBuilder.swift
//  Lodoos
//
//  Created by Cagla Efendioglu on 10.06.2023.
//

import Foundation

class SearchDetailBuilder {
    static func make(path: String) -> SearchDetailVC {
        let vc = SearchDetailVC()
        var service = SearchDetailService()
        let viewModel = SearchDetailViewModel(service: service, path: path)
        vc.searchVievModel = viewModel
        return vc
    }
}
