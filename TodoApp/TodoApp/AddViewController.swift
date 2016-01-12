//
//  AddViewController.swift
//  TodoApp
//
//  Created by Marquis Dennis on 1/12/16.
//  Copyright © 2016 Marquis Dennis. All rights reserved.
//

import UIKit
import Alamofire

class AddViewController: UIViewController {
  
  @IBOutlet weak var todoField:UITextField!
  
  @IBAction func addTodoItem() {
    Alamofire.request(.POST, "https://fast-peak-4759.herokuapp.com/todo", parameters: ["name":self.todoField.text!])

    self.navigationController!.popViewControllerAnimated(true)
  }
  
}
