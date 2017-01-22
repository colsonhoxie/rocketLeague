//
//  xboxOne.swift
//  rocketStats
//
//  Created by Colson Hoxie on 1/9/17.
//  Copyright © 2017 Colson Hoxie. All rights reserved.
//

import UIKit
import Alamofire
import Kanna
import Foundation

class xboxOneViewController: UIViewController {
    
    var xboxTag = ""
    static var xboxURL = "https://rocketleaguestats.com/profile/xboxone/"
    var counter = 0
    var xboxStats: [String] = []
    
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var saves: UILabel!
    @IBOutlet weak var mvps: UILabel!
    @IBOutlet weak var mvpPerc: UILabel!
    @IBOutlet weak var goals: UILabel!
    @IBOutlet weak var shots: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var shotAcc: UILabel!
    @IBOutlet weak var duelRankImage: UIImageView!
    @IBOutlet weak var doublesRankImage: UIImageView!
    @IBOutlet weak var standardRankImage: UIImageView!
    @IBOutlet weak var soloStandardRankImage: UIImageView!
    @IBOutlet weak var doublesDivision: UILabel!
    @IBOutlet weak var duelDivision: UILabel!
    @IBOutlet weak var soloStandardDivision: UILabel!
    @IBOutlet weak var standardDivision: UILabel!
    @IBOutlet weak var standardMMR: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xboxOneViewController.xboxURL += xboxTag
        
        let getStats = statScraper()

        getStats.scrapeForStats(URL: xboxOneViewController.xboxURL) {(completionHandler) in
            //print(completionHandler)
            if completionHandler {
                self.setStats(statArray: statScraper.stats)
                self.setRankImages()
                self.setDivisionLabels()
                self.standardMMR.text = statScraper.standard[2]
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //sets the labels to the according stat
    func setStats(statArray: Array<String>) -> Void {
        wins.text = statArray[4]
        saves.text = statArray[5]
        mvps.text = statArray[6]
        mvpPerc.text = statArray[7]
        goals.text = statArray[12]
        shots.text = statArray[13]
        assists.text = statArray[14]
        shotAcc.text = statArray[15]
    }
    
    func setRankImages() {
        self.duelRankImage.image = UIImage(named: statScraper.duels[0])
        self.doublesRankImage.image = UIImage(named: statScraper.doubles[0])
        self.soloStandardRankImage.image = UIImage(named: statScraper.soloStandard[0])
        self.standardRankImage.image = UIImage(named: statScraper.standard[0])
    }
    
    func setDivisionLabels() {
        doublesDivision.text = statScraper.doubles[1]
        duelDivision.text = statScraper.duels[1]
        soloStandardDivision.text = statScraper.soloStandard[1]
        standardDivision.text = statScraper.standard[1]
    }
}
