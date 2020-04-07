//
//  Parser.swift
//  rss_client
//
//  Created by temir on 08.04.2020.
//  Copyright © 2020 temir. All rights reserved.
//

import Foundation

protocol ParserProtocol: class {
    
    var articles: [Article]? { get set }
    
    func startParse(completion: @escaping((Bool) -> Void))
}

class Parser: NSObject, ParserProtocol {
    
    private var networkService = NetworkService()
    var articles: [Article]? = []
    
    private var currentArticle: Article?
    private var elementName = ""
    
    func startParse(completion: @escaping((Bool) -> Void)) {
        networkService.getData(completion: { (data, error) in
            if let data = data {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
                completion(true)
            } else if let error = error {
                print(error.localizedDescription)
                completion(false)
            }
        })
    }
}

extension Parser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            currentArticle = Article(title: "", imagePath: "", description: "")
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch elementName {
        case "title":
            currentArticle?.title += string
        case "itunes:image":
            currentArticle?.imagePath += string
        case "description":
            currentArticle?.title += string
        default:
            print("")
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            if let article = currentArticle {
                articles?.append(article)
            }
        }
    }
}
