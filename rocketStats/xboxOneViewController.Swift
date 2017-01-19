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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xboxOneViewController.xboxURL += xboxTag
        let getStats = statScraper()
        getStats.scrapeForStats(URL: xboxOneViewController.xboxURL)
        print(xboxStats)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //sets the labels to the according stat
    func setStats(statArray: Array<String>) -> Void {
        print(statArray)
        wins.text = statArray[4]
        saves.text = statArray[5]
        mvps.text = statArray[6]
        mvpPerc.text = statArray[7]
        goals.text = statArray[12]
        shots.text = statArray[13]
        assists.text = statArray[14]
        shotAcc.text = statArray[15]
    }
}
