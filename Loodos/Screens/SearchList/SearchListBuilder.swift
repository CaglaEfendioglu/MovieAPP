//
//  SearchListBuilder.swift
//  Lodoos
//
//  Created by Cagla Efendioğlu on 3.06.2023.
//

import Foundation

class SearchListBuilder {
    static func make() -> SearchListVC {
        let vc = SearchListVC()
        let service = SearchListService()
        let viewModel = SearchLitViewModel(service: service)
        vc.viewModel = viewModel
        return vc
    }
}
