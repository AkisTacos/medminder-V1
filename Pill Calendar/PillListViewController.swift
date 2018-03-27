//
//  PillListViewController.swift
//  Pill Calendar
//
//  Created by Aki Saito on 1/20/18.
//  Copyright © 2018 CHRYAKI. All rights reserved.
//

import UIKit
import Firebase

class PillListViewController  : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Instance Var
    var pillArray : [pillContent] = [pillContent]()
    
    @IBOutlet weak var pillTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set yourself as delegate and datasource
        pillTableView.delegate = self
        pillTableView.dataSource = self
        
        // register our pillcell
        pillTableView.register(UINib(nibName: "PillCell", bundle: nil), forCellReuseIdentifier: "customPillCell")
        
        configureTableView()
        retrievePillContent()
    }
    
    
    // Declare cellForRowAtIndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customPillCell", for: indexPath) as! CustomPillCell
        
        // called for every cell
        cell.pillName.text = pillArray[indexPath.row].drugName
        
        return cell
    }
    
    // Retrieve Pill Content
    func retrievePillContent(){
        let pillContentDB = Database.database().reference().child("Sender And Pill Name")
        
        pillContentDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            // retrieve data from db
            let user = snapshotValue["Sender"]!
            let medName = snapshotValue["Medication Name"]!
            
            // assign value to our pill content class
            let content = pillContent()
            content.drugName = medName
            content.name = user
            
            // send to array
            self.pillArray.append(content)
            
            // reload the table content
            self.configureTableView()
            self.pillTableView.reloadData()
        }
    }
    
    // Declare numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pillArray.count
        
    }
    func configureTableView() {
        pillTableView.rowHeight = UITableViewAutomaticDimension
        pillTableView.estimatedRowHeight = 120
    }
}









