//
//  PSN.swift
//  rocketStats
//
//  Created by Colson Hoxie on 1/12/17.
//  Copyright © 2017 Colson Hoxie. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class PSNViewController: UIViewController {
    
    var psnTag = ""
    var psnURL = "https://rocketleaguestats.com/profile/PS4/"
    var stats: [String] = []
    var counter = 0
    
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
        
        self.scrapeForStats()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrapeForStats() -> Void {
        psnURL += psnTag
        
        Alamofire.request(psnURL).responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            if let nodes = doc.body?.xpath("//table[contains(@class,'profile_player')]/tbody/tr/td") {
                while counter != 16 {
                    stats.append(nodes[counter].text!)
                    counter += 1
                }
            }
            self.setStats(statArray: stats)
            stats = []
        }
    }
    
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
