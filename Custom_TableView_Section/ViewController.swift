//
//  ViewController.swift
//  Custom_TableView_Section
//
//  Created by Enamul Haque on 10/16/19.
//  Copyright © 2019 Enamul Haque. All rights reserved.
//

import UIKit

struct Category {
    let name : String
    var items : [[String:Any]]
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var originalArr = [[String:Any]]();
    var recentArr = [[String:Any]]();
    var searchArrRes = [[String:Any]]()
    var searching:Bool = false
    
    //
    var sections = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign delegate  don't forget
        txtName.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        recentArr =   [
            ["name": "Enamul", "number": "+8800000003"],
            ["name": "Enam", "number": "+8800000004"]
        ]
        
        originalArr = [
            ["name": "abdul", "number": "+8800000001"],
            ["name": "abdin", "number": "+8800000002"],
            ["name": "Enamul", "number": "+8800000003"],
            ["name": "enam", "number": "+8800000004"],
            ["name": "Rafi", "number": "+8800000005"],
            ["name": "Ehaque", "number": "+8800000006"]
        ]
        
        //my array
        sections = [
            Category(name:"Recent", items:recentArr),
            Category(name:"ALL", items:originalArr)
        ]
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
           guard let tableView = view as? UITableViewHeaderFooterView else { return }
           // tableView.backgroundView?.backgroundColor = UIColor.black
           tableView.textLabel?.textColor = UIColor.red
       }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        //input text
        let searchText  = textField.text! + string
        //add matching text to arrya
        searchArrRes = self.originalArr.filter({(($0["name"] as! String).localizedCaseInsensitiveContains(searchText))})
       
        
        if(searchArrRes.count == 0){
            searching = false
        }else{
            searching = true
        }
        self.tableView.reloadData();
        
        return true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if( searching == true){
            return 1
        }
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if( searching == true){
            return ""
        }
        return self.sections[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( searching == true){
           return searchArrRes.count
        }else{
            let items = self.sections[section].items
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Custom_cell
        //  var dict = itemsA[indexPath.section]
        
        if( searching == true){
            var dict = searchArrRes[indexPath.row]
            cell.name.text = dict["name"] as? String
            cell.number.text = dict["number"] as? String
        }else{
            let items = self.sections[indexPath.section].items
            let item = items[indexPath.row]
            cell.name.text = item["name"] as? String
            cell.number.text = item["number"] as? String
            
        }
        
        return cell
    }
    
    
}

