//
//  AFWrapper.swift
//  rocketStats
//
//  Created by Colson Hoxie on 1/16/17.
//  Copyright © 2017 Colson Hoxie. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Kanna

class statScraper: NSObject {
    
    static var ranks: [String] = []
    static var stats: [String] = []
    
    func scrapeForStats(URL: String) {
        Alamofire.request(URL).responseString { response in
            print("hello")
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            //finds the stats of the user
            if let nodes = doc.body?.xpath("//table[contains(@class,'profile_player')]/tbody/tr/td") {
                self.setStatArray(htmlDoc: nodes)
            }
            //This finds the rank of the user. x = 0 is solo, x= 2 is doubles, x=3 is solo standard, x=4 is standard
            if let rankNode = doc.body?.xpath("//p[@class = 'profile_tier-name']") {
                self.setRankArray(newHtmlDoc: rankNode)
            }
        }
    }
    
    func setStatArray(htmlDoc: XPathObject) -> Void {
        var counter = 0
        
        while counter != 16 {
            statScraper.stats.append(htmlDoc[counter].text!)
            counter += 1
        }
        print(statScraper.stats)
    }
    
    func setRankArray(newHtmlDoc: XPathObject) -> Void {
        var newCounter = 0
        
        while newCounter != 3 {
            statScraper.ranks[newCounter] = newHtmlDoc[newCounter].text!
            statScraper.ranks[newCounter] = statScraper.ranks[newCounter].replacingOccurrences(of: "\n", with: " ")
            newCounter += 1
        }
        print(statScraper.ranks)
    }
}
