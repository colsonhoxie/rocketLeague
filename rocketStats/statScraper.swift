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
    static var duels: [String] = []
    static var doubles: [String] = []
    static var soloStandard: [String] = []
    static var standard: [String] = []
    
    func scrapeForStats(URL: String, completionHandler: @escaping (Bool) -> ()) {
        Alamofire.request(URL).responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTMLStats(html: html)
                self.parseHTMLRank(html: html)
            }
            completionHandler(true)
        }


    }
    
    func parseHTMLStats(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            //finds the stats of the user
            if let nodes = doc.body?.xpath("//table[contains(@class,'profile_player')]/tbody/tr/td") {
                self.setStatArray(htmlDoc: nodes)
            }
        }
        
    }
    
    func parseHTMLRank(html: String) -> Void {
        if let doc1 = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            //This finds the rank of the user. x = 0 is solo, x= 2 is doubles, x=3 is solo standard, x=4 is standard
            if let nodeOne = doc1.body?.xpath("//p[@class = 'profile_tier-name']") {
                self.rankArray(newHtmlDoc: nodeOne)
            }
        }
    }
    
    func setStatArray(htmlDoc: XPathObject) -> Void {
        var counter = 0
        
        while counter != 16 {
            statScraper.stats.append(htmlDoc[counter].text!)
            counter += 1
        }
    }
    
    func rankArray(newHtmlDoc: XPathObject) -> Void {
        var counter = 0
        
        while counter != 4 {
            statScraper.ranks.append(newHtmlDoc[counter].text!)
            statScraper.ranks[counter] = statScraper.ranks[counter].replacingOccurrences(of: "\n", with: "")
            counter += 1
        }

        statScraper.duels = statScraper.ranks[0].components(separatedBy: "            ")
        statScraper.doubles = statScraper.ranks[1].components(separatedBy: "            ")
        statScraper.soloStandard = statScraper.ranks[2].components(separatedBy: "            ")
        statScraper.standard = statScraper.ranks[3].components(separatedBy: "            ")
        self.cleanDuelsArray()
        self.cleanSoloStandardArray()
        self.cleanDoublesArray()
        self.cleanStandardArray()
    }
    
    func cleanDuelsArray() -> Void {
        statScraper.duels.removeLast()
        statScraper.duels.removeFirst()
        statScraper.duels.removeFirst()
        statScraper.duels.remove(at: 1)
        statScraper.duels.remove(at: 2)
    }
    
    func cleanDoublesArray() -> Void {
        statScraper.doubles.removeLast()
        statScraper.doubles.removeFirst()
        statScraper.doubles.removeFirst()
        statScraper.doubles.remove(at: 1)
        statScraper.doubles.remove(at: 2)
    }
    
    func cleanSoloStandardArray() -> Void {
        statScraper.soloStandard.removeLast()
        statScraper.soloStandard.removeFirst()
        statScraper.soloStandard.removeFirst()
        statScraper.soloStandard.remove(at: 1)
        statScraper.soloStandard.remove(at: 2)
    }
    
    func cleanStandardArray() -> Void {
        statScraper.standard.removeLast()
        statScraper.standard.removeFirst()
        statScraper.standard.removeFirst()
        statScraper.standard.remove(at: 1)
        statScraper.standard.remove(at: 2)
    }
}
