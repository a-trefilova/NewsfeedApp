//
//  XMLParser.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 10.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit


class FeedParser: NSObject, XMLParserDelegate {
    private var rssItems: [RSSItem] = []
    private var currentElement = ""
    private var currentTitle: String = ""
    private var currentDescription: String = ""
    private var currentCategory: String = ""
    private var currentImageUrl: String = ""
    private var currentPubdateString: String = ""
    private var currentFullText: String = ""
    
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    private var parsCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)? ) {
        self.parserCompletionHandler = completionHandler
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
        task.resume()
        
        
    }
    
    func updateFeed(url: String, completionHandler: (([RSSItem]) -> Void)? ) {
        self.parsCompletionHandler = completionHandler
         URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
        task.resume()
        
        
    }
    
    
    
    //MARK: XMLParserDelegate
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        switch currentElement {
        case "item":
            currentTitle = ""
            currentDescription = ""
            currentCategory = ""
            currentImageUrl = ""
            currentFullText = ""
        case "enclosure":
            if let urlString = attributeDict["url"] {
                currentImageUrl += urlString
            }
        case "pubdate":
            currentPubdateString = ""
        default:
            break
        }

    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title" : currentTitle += string
        case "description": currentDescription += string
        case "category" : currentCategory += string
        case "yandex:full-text": currentFullText += string
        case "pubDate":
            currentPubdateString += string
            currentPubdateString = String(currentPubdateString.dropLast(8))
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle,
                                  description: currentDescription,
                                  category: currentCategory,
                                  enclosure: currentImageUrl,
                                  fullText: currentFullText,
                                  pubdateString: currentPubdateString)
            self.rssItems.append(rssItem)
            currentPubdateString = ""
            
        }
    }
    
    
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
        parsCompletionHandler?(rssItems)
        
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }

}




