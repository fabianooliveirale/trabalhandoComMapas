//
//  ApiClimaTableViewController.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 13/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import UIKit
import SVProgressHUD

class ApiClimaTableViewController: UITableViewController {
    
    let rota: String = "https://api.hgbrasil.com/"
    let key: String = "659b4b98"
    var woeid: String = ""
    var climaJson : ClimaJson!
    var climas: [ClimaJson] = []
    var img: UIImage!
    var txtField1: UITextField!
    var txtField2: UITextField!
    
    @IBAction func salvar(_ sender: Any) {
        
                let alert = UIAlertController(title: "woeId", message: "Coloque o woeid da cidade.", preferredStyle: .alert)
               // UIAlertControllerStyle.Alert
        
                alert.addTextField(configurationHandler: addTextField1)
//                alert.addTextField(configurationHandler: addTextField2)
        
                alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction)in
                }))
                alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                    
                    self.woeid = (self.txtField1.text!)
                    if self.woeid == "" {
                        self.woeid = "455822"
                    }
                    
                    self.getClima()
                    
                }))
                self.present(alert, animated: true, completion: nil)
    }
    
    func addTextField1(textField: UITextField!)
    {
        textField.placeholder = "Digite da cidade woeId"
        txtField1 = textField
    }
//
//    func addTextField2(textField: UITextField!)
//    {
//        textField.placeholder = "UF"
//        txtField2 = textField
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController!.navigationBar.tintColor = UIColor.black;
        
    }
    
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let dao = ClimaJsonDao()
            dao.remove(index: indexPath.row)
            refresh()
        }
        
    }
    
    func refresh(){
        let dao = ClimaJsonDao()
        climas = dao.listar()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refresh()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return climas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let climaJson: ClimaJson = climas [indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellClimaJson", for: indexPath) as! ClimaCell// indentificado de CEL na main story boad
        cell.name.text = climaJson.results.cityName
        cell.clima.text = climaJson.results.conditionSlug
        cell.hora.text = climaJson.results.time
        cell.data.text = climaJson.results.date
        let text = climaJson.results.conditionSlug
        if((text?.contains("cloudly"))!){
            img = UIImage(named: "nublado")!
            cell.img.image = img
        }else if (text?.contains("storm"))!
        {
            img = UIImage(named: "blustery")!
            cell.img.image = img
        }else{
            img = UIImage(named: "sunny")!
            cell.img.image = img
        }
        return cell
    }

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
    
    //659b4b98
    //https://api.hgbrasil.com/weather?key=659b4b98&city_name=Campinas,SP

    func getClima(){
        SVProgressHUD.show()
        ClimaApi.climaDetalhes(woeid: self.woeid, completion: { item in
            if let c :ClimaJson = item {
                let cli:ClimaJsonDao = ClimaJsonDao()
                cli.salvar(clima: c)
                self.refresh()
               // self.climas.append(c)
//                print(self.climas.count)
//                for c in self.climas{
//                   print(c.results.cityName)
//                   print(c.results.sunset)
//                }
            }
           SVProgressHUD.dismiss()
        })
    }
}
