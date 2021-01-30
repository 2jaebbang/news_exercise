//
//  ViewController.swift
//  news_exercise
//
//  Created by 이재영 on 2021/01/30.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    var newsData : Array<Dictionary<String, Any>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getNews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = newsData {
            return news.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        let idx = indexPath.row
        if let news = newsData {
            let row = news[idx]
            if let v = row as? Dictionary<String, Any> {
                cell.labelText.text = "\(v["title"]!)"
            }
    }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name : "Main", bundle: nil)
        let newsDetail = storyboard.instantiateViewController(identifier: "NewsDetailController") as! NewsDetailController
        if let news = newsData {
            let row = news[indexPath.row]
            if let v = row as? Dictionary<String, Any> {
                if let imageUrl = v["urlToImage"] as? String {
                    newsDetail.imageUrl = imageUrl
                }
                if let dsec = v["description"] as? String {
                    newsDetail.dsec = dsec
                }
            }
    }
       // showDetailViewController(newsDetail, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "NewsDetail" == segue.identifier {
            if let controller = segue.destination as? NewsDetailController {
                if let news = newsData {
                   if let indexPath = tableView.indexPathForSelectedRow { //indexpath 가져오기 
                    let row = news[indexPath.row]
                    if let v = row as? Dictionary<String, Any> {
                        if let imageUrl = v["urlToImage"] as? String {
                            controller.imageUrl = imageUrl
                        }
                        if let dsec = v["description"] as? String {
                            controller.dsec = dsec
                        }
                    }
                    }
                    
            }
        }
    }
    }

    func getNews() {
        let url = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=248805a55af84f14b13e8e69456fb6dd"
       let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let dataJson = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>   //swift에서 data는 dictionary 타입임 (key, value)
                
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                    self.newsData = articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
        }
}


