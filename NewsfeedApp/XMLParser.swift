//
//  XMLParser.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 10.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyXMLParser


class FeedParser: NSObject, XMLParserDelegate {

    
    private var rssItems: [RSSItem] = []
    private var enclosureDataItems: [Enclosure] = []
    
    private var currentElement = ""
    private var currentTitle: String = ""
    
    
    private var currentLink: String = ""
    private var currentDescription: String = ""
    private var currentPubdate: Date?
    private var currentCategory: String = ""
    
    private var currentEnclosure = ""
    private var currentImageElement = ""
    private var currentImageUrl = ""
    
    private var currentImageType = ""
    private var currentImageWidth = ""
    private var currentImageHeight = ""
    
    private var currentPubdateString = ""
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
            currentImageUrl = ""
            
            currentImageWidth = ""
            currentImageHeight = ""
            
            
            currentTitle = ""
            currentLink = ""
            currentDescription = ""
            
            currentCategory = ""
            currentFullText = ""
        case "enclosure":
            
            if let urlString = attributeDict["url"],
                let width = attributeDict["width"],
                let height = attributeDict["height"] {
                currentImageUrl += urlString
                currentImageWidth += width
                currentImageHeight += height
                
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
        case "link" : currentLink += string
        case "description": currentDescription += string
       // case "pubdate": currentPubdateString += string
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
           
//            let rssItem = RSSItem(title: currentTitle,
//                                  link: currentLink,
//                                  description: currentDescription,
//                                  category: currentCategory,
//                                  enclosure: Enclosure(url: currentImageUrl,
//                                                       type: currentImageType,
//                                                       width: Int(currentImageWidth) ?? 00,
//                                                       height: Int(currentImageHeight) ?? 00),
//                                  fullText: currentFullText,
//                                  pubdateString: currentPubdateString)
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
    
    
//    private func formattingDate (string: String) -> String {
//
//        let dateFormatter = DateFormatter()
//        let tempLocale = dateFormatter.locale // save locale temporarily
//        dateFormatter.locale = Locale(identifier: "ru_RU") // set locale to reliable US_POSIX
//        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
//        guard let date = dateFormatter.date(from: string) else { return "" }
//        dateFormatter.dateFormat = "MMM d, h:mm a" ; //"dd-MM-yyyy HH:mm:ss"
//        dateFormatter.locale = tempLocale // reset the locale --> but no need here
//        let dateString = dateFormatter.string(from: date)
//        print("EXACT_DATE : \(dateString)")
//        return dateString
//    }

    
}

class NetworkingManager {
    static func downloadImage(url: String, completion: @escaping (_ data: Data)->()) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        } .resume()
    }
}


class NetworkManager {
    let urlString = "https://www.vesti.ru/vesti.rss"
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchData(targetVC:  UIViewController, handler: @escaping ([RSSItem]?) -> ()) {
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        AF.request(urlString).response { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            if let data = response.data {
                let parsedData = self.parseXML(from: data)
                DispatchQueue.main.async {
                    handler(parsedData)
                }
            }
             
        }
    }
    
    func parseXML(from data: Data) -> [RSSItem]? {
        let xml = XML.parse(data)
        let path = ["rss", "channel", "item"]
        let rssItems = xml[path].map { RSSItem.init(title: $0["title"].text ?? "",
                                                    description: $0["description"].text ?? "",
                                                    category: $0["category"].text ?? "",
                                                    enclosure: $0["enclosure"].attributes["url"] ?? "",
                                                    fullText: $0["yandex:full-text"].text ?? "",
                                                    pubdateString: $0["pubDate"].text ?? "")
        }
        return rssItems
    }
    
}
