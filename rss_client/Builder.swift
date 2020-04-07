//
//  Builder.swift
//  rss_client
//
//  Created by temir on 08.04.2020.
//  Copyright © 2020 temir. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let viewController = MainViewController()
        let parser = Parser()
        let presenter = MainViewPresenter(view: viewController, parser: parser)
        
        viewController.presenter = presenter
        return viewController
    }
}
