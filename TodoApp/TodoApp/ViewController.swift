//
//  ViewController.swift
//  TodoApp
//
//  Created by Marquis Dennis on 1/11/16.
//  Copyright © 2016 Marquis Dennis. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var JSONArray:NSMutableArray?
  var newArray = [String]()
  var IDArray = [String]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func downloadAndUpdate() {
    newArray.removeAll()
    IDArray.removeAll()
    
    Alamofire.request(.GET, "https://fast-peak-4759.herokuapp.com/todo").responseJSON { response in
      print(response.request)
      print(response.response)
      print(response.data)
      print(response.result)
      
      if let JSON = response.result.value {
        self.JSONArray = JSON as? NSMutableArray
        for item in self.JSONArray! {
          print(item["name"]!)
          let string = item["name"]!
          let id = item["_id"]! as! String
          
          self.IDArray.append(id)
          self.newArray.append(string as! String)
        }
        
        print("New array is \(self.newArray)")
        
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    downloadAndUpdate()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController : UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    
    cell.textLabel?.text = self.newArray[indexPath.row]
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.newArray.count
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      Alamofire.request(.DELETE, "https://fast-peak-4759.herokuapp.com/todo/\(self.IDArray[indexPath.row])")
      self.downloadAndUpdate()
    }
  }
}

extension ViewController : UITableViewDelegate {

}