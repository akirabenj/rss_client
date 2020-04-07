//
//  MainPresenter.swift
//  rss_client
//
//  Created by temir on 08.04.2020.
//  Copyright © 2020 temir. All rights reserved.
//

import Foundation

protocol MainViewPresenterProtocol: class {
    
    var articles:[Article]? { get set }
    
    init(view: MainViewProtocol, parser: ParserProtocol)
    
    func getArticles()
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    var articles: [Article]?
    weak var mainView: MainViewProtocol?
    weak var parser: ParserProtocol?
    
    required init(view: MainViewProtocol, parser: ParserProtocol) {
        self.mainView = view
        self.parser = parser
        getArticles()
    }
    
    func getArticles() {
        parser?.startParse(completion: { [weak self] fetched in
            DispatchQueue.main.async {
                if fetched {
                    self?.articles = self?.parser?.articles
                    self?.mainView?.success()
                } else {
                    self?.mainView?.failure()
                }
            }
        })
    }
}
