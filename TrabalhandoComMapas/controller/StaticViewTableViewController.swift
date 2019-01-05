//
//  StaticViewTableViewController.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 04/01/19.
//  Copyright © 2019 exemplos. All rights reserved.
//

import UIKit

class StaticViewTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var upConst: NSLayoutConstraint!
    @IBOutlet weak var cel2: UITableViewCell!
    @IBOutlet weak var cel1: UITableViewCell!
    @IBOutlet weak var cel3: UITableViewCell!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var editText: UITextField!
    
    var num: Int = 0
    var h1: CGFloat = 220
    var h2: CGFloat = 220
    var h3: CGFloat = 1000
    
    
    
    @IBAction func add(_ sender: Any) {
        
        if num == 0 {
            
            h1 = 220
            h2 = 220
            h3 = 0
            num = num + 1
            if editText.isHidden == true {
                 upConst.constant = 49
                 editText.isHidden = false
                editText.frame.size.height = 700
            }else {
                upConst.constant = 8
                editText.isHidden = true
                
            }
           
            
        } else if num == 1{
            
            h1 = 220
            h2 = 0
            h3 = 0
            num = num+1
            if editText.isHidden == true {
                upConst.constant = 49
                editText.isHidden = false
                editText.frame.size.height = 700
//                var gr: CGRect = editText.frame
//                gr.size.height = 700
//                editText.frame = gr
            }else {
                upConst.constant = 8
                editText.isHidden = true
                
            }
            
        } else if num == 2{
            
            h1 = 220
            h2 = 220
            h3 = 1000
            num = 0
            if editText.isHidden == true {
                upConst.constant = 49
                editText.isHidden = false
                editText.frame.size.height = 700
//                var gr: CGRect = editText.frame
//                gr.size.height = 500
//                editText.frame = gr
            }else {
                upConst.constant = 8
                editText.isHidden = true
            }
            
        }
        
        self.tableView.reloadData()
        
    }
    
    
    // SEGMENTED EXAMPLE
    
    @IBOutlet weak var segOut: UISegmentedControl!
    @IBAction func segAction(_ sender: Any) {
        
        
        print(segOut.selectedSegmentIndex)
        
    }
    
    // SLIDER EXAMPLE
    
    @IBOutlet weak var sliOut: UISlider!
    @IBAction func sli(_ sender: Any) {
        
        print(sliOut.value)
        
    }
    
    
    // SWITCH EXAMPLE
    // dados iniciando em viewDidLoad() Verificar! e 
    @IBOutlet weak var switchOut: UISwitch!
    @IBAction func switchAction(_ sender: Any) {
        
        print(switchOut.isOn)
        
    }
    
    
    // PICKER EXAMPLE
    
    var pickerData: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    @IBOutlet weak var pickerOut: UIPickerView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(pickerData[row])
        self.view.endEditing(true)
    }
    
    
    // fim picker example
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PICKER EXAMPLE
        self.pickerOut.delegate = self
        self.pickerOut.dataSource = self
        
        // FIM PICKER EXAMPLE
    
        label1.text = "GARPI"
        
        label2.text = "GARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRU"
        
        label3.text = "GARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRU"
        
        label4.text = "GARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRU"
        
        label5.text = "GAR"
        
        label6.text = "GARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRUGARPIRU"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0 {
            return h1
        }else if indexPath.row == 1 {
            return h2
        }else if indexPath.row == 2 {
            return h3
        }
        return 100
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
