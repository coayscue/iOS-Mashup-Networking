//
//  TheTableViewController.swift
//  RoutingWork
//
//  Created by Christian Ayscue on 9/12/15.
//  Copyright (c) 2015 christianayscue. All rights reserved.
//

import UIKit

var dataToShow: JSON? = nil

class TheTableViewController: UITableViewController {

    var routesArr = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if routesArr.count == 0{
            //create and configure a request
            var request = NSMutableURLRequest(URL: NSURL(string: "http://mashup-app.herokuapp.com/api/routes")!) //this will take up to a minute as the website is hosted for free on heroku
            request.HTTPMethod = "GET"
            
            //create a session and on it a task with the request
            var session = NSURLSession.sharedSession()
            var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                //convert the data
                var json = JSON(data: data);
                println("Data: \(json)")
                self.routesArr = json.array!
                self.tableView.reloadData()
            })
            
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        println("numSections");
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println("numRows")
        return routesArr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        println("cell")
        
        cell.textLabel?.text = routesArr[indexPath.row]["name"].stringValue
        println(routesArr[indexPath.row]["name"].stringValue)
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataToShow = routesArr[indexPath.row]
        self.performSegueWithIdentifier("show_data", sender: nil)
    }

}
