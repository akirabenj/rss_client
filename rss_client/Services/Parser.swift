//
//  Parser.swift
//  rss_client
//
//  Created by temir on 08.04.2020.
//  Copyright © 2020 temir. All rights reserved.
//

import Foundation

protocol ParserProtocol: class {
    func startParse(completion: @escaping((Bool) -> Void))
}

class Parser: NSObject, ParserProtocol {
    
    var networkService: Networking?
    var articles: [Article] = []
    
    private var currentArticle: Article?
    private var articleCharacter = ""
    
    func startParse(completion: @escaping((Bool) -> Void)) {
        networkService?.getData(completion: { [weak self] (data, error) in
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
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        articleCharacter = string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "title":
            currentArticle?.title = articleCharacter
        case "itunes:image":
            currentArticle?.imagePath = articleCharacter
        case "description":
            currentArticle?.title = articleCharacter
        default:
            print("parse error")
        }
        
        if let article = currentArticle {
            articles.append(article)
        }
    }
}
