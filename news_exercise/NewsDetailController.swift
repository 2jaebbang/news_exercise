//
//  NewsDetailController.swift
//  news_exercise
//
//  Created by 이재영 on 2021/01/30.
//

import UIKit

class NewsDetailController: UIViewController {
    
    
    
    

    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    var imageUrl : String?
    var dsec : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let img = imageUrl {
            do {
                let data = try Data(contentsOf: URL(string: img)!)
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
               
            } catch {
                print(error)
            }
            
        }
        
        if let d = dsec {
            self.LabelMain.text = d
        }
       
    }

}
