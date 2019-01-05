//
//  MinhasViagensViewController.swift
//  TrabalhandoComMapas
//
//  Created by Anderson Soares on 21/12/18.
//  Copyright © 2018 exemplos. All rights reserved.
//

import UIKit

class MinhasViagensViewController: UITableViewController {

    var lista: [Viagem] = []
    var controle: String = "add"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let dao:ViagemDao = ViagemDao()
            dao.remover(index: indexPath.row)
            refresh()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // initLista()
        refresh()
        // tableView.reloadData()
    }
    
    func refresh(){
        let dao = ViagemDao()
        lista = dao.list()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        controle = "lista"
        performSegue(withIdentifier: "segueLista", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueLista"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selected = lista[indexPath.row]
                let vcDestino = segue.destination as! MapMinhasViagensViewController
                
                vcDestino.vaigem = selected
                vcDestino.indiceSelecionado = indexPath.row
                vcDestino.controle = controle
                
            } 
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "cellViagem", for: indexPath)// indentificado de CEL na main story boad
        
            let l: Viagem = lista [indexPath.row]
            cell.textLabel?.text = l.local
            
       
      
       
        return cell
    }
    
}
