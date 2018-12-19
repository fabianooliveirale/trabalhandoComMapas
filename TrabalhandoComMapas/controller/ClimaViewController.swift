//
//  ClimaViewController.swift
//  Trabalhando com mapas
//
//  Created by Anderson Soares on 11/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import UIKit

class ClimaViewController: UITableViewController {
   
    let rota: String = "https://samples.openweathermap.org/"
    let key: String = "ed6efeb0344038a7952e6328512ddc0d"
    var txtField1: UITextField!
    var txtField2: UITextField!
    var climas: [Clima] = []
    
    
    @IBAction func save(_ sender: Any) {
//        let alert = UIAlertController(title: "Enter Input", message: "", preferredStyle: .alert)
//       // UIAlertControllerStyle.Alert
//        
//        alert.addTextField(configurationHandler: addTextField1)
//        alert.addTextField(configurationHandler: addTextField2)
//        
//        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction)in
//        }))
//        alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
//           self.zip = (self.txtField1.text!)
//           self.country = (self.txtField2.text!)
//           self.climaCidade()
//        }))
//        self.present(alert, animated: true, completion: nil)
        climaCidade()
    }
    
    func addTextField1(textField: UITextField!)
    {
        textField.placeholder = "Cidade"
        txtField1 = textField
    }
    
    func addTextField2(textField: UITextField!)
    {
        textField.placeholder = "País"
        txtField2 = textField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let dao = ClimaDao()
            dao.remove(index: indexPath.row)
            refresh()
        }
        
    }
    
    func refresh(){
        let dao = ClimaDao()
        climas = dao.listar()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refresh()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return climas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellClima", for: indexPath)
        
        cell.textLabel?.text = climas[ indexPath.row ].name
        
        // Configure the cell...
        
        return cell
    }
    
    
    func climaCidade(){
        let clima: Clima! = Clima()
        //print(clima.name)
        if let url = URL(string: rota+"data/2.5/weather?zip=,us&appid="+key){
            //print(url)
            let tarefa = URLSession.shared.dataTask(with: url) { (data, requisicao, erro) in
                if erro == nil {
                    if let dataReturn = data {
                        do{
                            if let oJson = try JSONSerialization.jsonObject(with: dataReturn, options: []) as? [String:Any] {
                                 print(oJson)
                                if let coord = oJson["coord"] as? [String: Any]{
                                    if let result = coord["lon"] as? Double {
                                        print(result)
                                        if let cli: Clima = clima{
                                            print(clima.name)
                                             cli.lon = String(result)
                                        }
                                    }
                                    
                                    if let result = coord["lat"] as? Double {
                                        if let cli: Clima = clima{
                                           cli.lat = String(result)
                                        }
                                        
                                    }
                                }
                                
                                if let main = oJson["main"] as? [String: Any]{
                                    //print(main)
                                    if let result1 = main["temp"] as? Double {
                                        if let cli: Clima = clima{
                                            cli.temp = String(result1)
                                        }
                                        
                                    }
                                    
                                    if let result2 = main["pressure"] as? Double {
                                        if let cli: Clima = clima{
                                           cli.pressure = String(result2)
                                        }
                                        
                                    }
                                }
                                
                                
                                if let coord = oJson["wind"] as? [String: Any]{
                                    
                                    if let result = coord["speed"] as? Double {
                                        if let cli: Clima = clima{
                                            cli.speed = String(result)
                                        }
                                        
                                    }
                                    
                                    if let result = coord["deg"] as? Double {
                                        if let cli: Clima = clima{
                                            cli.deg = String(result)
                                        }
                                       
                                    }
                                    
                                    
                                }
                                
                                
                                if let result = oJson["id"] as? Int{
                                    if let cli: Clima = clima{
                                           cli.id = String(result)
                                    }
                                 
                                    
                                }
                                
                                if let result = oJson["name"] as? String{
                                    if let cli: Clima = clima{
                                        cli.name = result
                                    }
                                   
                                }
                                
                                print(clima.name)
                                if let cli: Clima = clima{
                                    print(cli.name)
                                    if(cli.name != ""){
                                        print(cli.name)
                                        if(cli.id != ""){
                                            print(cli.id)
                                            let daoClima = ClimaDao()
                                            daoClima.salvar(clima: cli)
                                            print(daoClima.listar().count)
                                        }
                                    }
                                }
                            }
                        }catch{
                            print ("ERRO!")
                        }
                    }
                }else{
                    print("erro!")
                }
            }
            tarefa.resume()
        }
        
    }
    
    
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


