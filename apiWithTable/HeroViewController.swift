//
//  HeroViewController.swift
//  apiWithTable
//
//  Created by junior on 4/28/20.
//  Copyright © 2020 junior. All rights reserved.
//

import UIKit

// extension de imagen
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class HeroViewController: UIViewController {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var image: UIImageView!
    
     var hero: Question?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nombre.text = hero?.localized_name
        
        // para cargar la imagen
        let urlString = "https://api.opendota.com" + (hero?.img)!
        let url = URL(string: urlString)
        image.downloaded(from: url!)
    }
    

}
