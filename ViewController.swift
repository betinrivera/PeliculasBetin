//
//  ViewController.swift
//  PeliculasBetin
//
//  Created by Alumno on 25/10/18.
//  Copyright © 2018 Alumno. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var urlPelicula = "http://www.omdbapi.com/?apikey=1d2750f9&t=i"
    var pelicula : String?
    var completada : String?

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAño: UILabel!
    @IBOutlet weak var lblDuracion: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblGenero: UILabel!
    @IBOutlet weak var aiCargar: UIActivityIndicatorView!
    @IBOutlet weak var txtFieldBuscar: UITextField!
    @IBOutlet weak var lblEncontrada: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doTapBuscar(_ sender: Any) {
        aiCargar.startAnimating()
        
        pelicula = txtFieldBuscar.text!
        
        urlPelicula = "http://www.omdbapi.com/?apikey=1d2750f9&t=i"
        
        if (pelicula != "") {
            
            urlPelicula = "https://www.omdbapi.com/?apikey=1d2750f9&t=\(pelicula!)"
        }
        
        Alamofire.request(urlPelicula).responseJSON { response in
            self.lblTitulo.text = ""
            self.lblAño.text = ""
            self.lblDuracion.text = ""
            self.lblRating.text = ""
            self.lblDirector.text = ""
            self.lblGenero.text = ""
            self.lblEncontrada.text = ""
            
            if let dictResponse = response.result.value as? NSDictionary {
                if let respuesta = dictResponse.value(forKey: "Response") as? String{
                    self.completada = respuesta
                }
                if self.completada == "True" {
                    
                    if let nombre = dictResponse.value(forKey: "Title") as? String {
                        self.lblTitulo.text = nombre
                    }
                    if let calificacion = dictResponse.value(forKey: "Rated") as? String {
                        self.lblRating.text = calificacion
                    }
                    if let año = dictResponse.value(forKey: "Year") as? String {
                        self.lblAño.text = año
                    }
                    if let duracion = dictResponse.value(forKey: "Runtime") as? String {
                        self.lblDuracion.text = duracion
                    }
                    if let director = dictResponse.value(forKey: "Director") as? String {
                        self.lblDirector.text = director
                    }
                    if let genero = dictResponse.value(forKey: "Genre") as? String {
                        self.lblDirector.text = genero
                        self.pelicula = ""
                        self.aiCargar.stopAnimating()
                    }
                    
                }
                else {
                    self.lblEncontrada.text = "Pelicula No Encontrada"
                    self.pelicula = ""
                    self.aiCargar.stopAnimating()
                }
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
        
        
        
        
    }
    

}

