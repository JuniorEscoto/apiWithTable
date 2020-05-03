//
//  ViewController.swift
//  apiWithTable
//
//  Created by junior on 4/28/20.
//  Copyright © 2020 junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    // creamos un arrelgo de la clase herostats que contiene nuestro struc, agarramos el nombre
    var herosta = [Question]()
    var list = ["Junior" : "mujer", "Juan" : "juana", "Pedro": "pedra", "maria": "mario"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // probando
        donwloadJson {
            print("exito")
            
            // cargando la table view
            self.table.reloadData()
        }
        
        // esta parte tiene que ver con confiugrar la tbla para mostrar datos
        table.delegate = self
        table.dataSource = self // luego de esto debemos colocar esas referncias en la table: viewcontroller
        
        
    }
    
    // funciones para la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return herosta.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // creando una celda
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //cell.textLabel?.text = herosta[indexPath.row].name.capitalized
        cell.textLabel?.text = herosta[indexPath.row].name
        return cell
    }
    
    // esta funcion es para dar click a la tabla y pasar a la otra vista
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    // preparando
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            // esto es como que esta haciendo una instancia, puedo acceder a los campos de heroViewController con la constante hero
            destination.hero = herosta[(table.indexPathForSelectedRow?.row)!]
        }
    }
    
    // funcion para cargar la data, completed es un tipo de parametro
    func donwloadJson( completed : @escaping () -> ())  {
        // capturamos la direcion json y la guardaamos un ulr
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        // opteniendo el json en urlsesion
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do {
                    self.herosta = try JSONDecoder().decode([Question].self, from: data!)
                   //  print("Result: ", self.herosta[1].address.street)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch  {
                    print("Error")
                }
                
            }
        }.resume() // no olvidar siempre poner el resume
    }


}

