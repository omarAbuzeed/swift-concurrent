//
//  HomeViewController.swift
//  omartask2
//
//  Created by Omar on 06/06/2026.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    var posts: PostsResponse?
    var quotes: QuotesResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        
//MARK: - 2 in pararel -> async let
        Task {
            try await getData()
            
            await MainActor.run {
                myTableView.reloadData()
            }
            
        }
        
        
        
//MARK: - 2 in parrarel second way -> dispatch Group
        
      //  getData2()
        
        
        
    }
    //MARK: - 2 in pararel
    func getData() async throws {
    
            do {
                
                async let posts = fetchPostsModerenWay()
                async let quotes = fetchQuetesModerenWay()
                
                let (pos, quot) = try await (posts, quotes)
                
                self.quotes = quot
                self.posts = pos
             
            } catch {
                print("error: \(error)")
            }
    }
    
    func getData2() {
        let group = DispatchGroup()
        
        
        group.enter()
        fetchQuetesGCD { [weak self] result in
            switch result {
            case .failure(let e):
                print(e)
            case .success(let q):
                self?.quotes = q
            }
            group.leave()
        }
        
        group.enter()
        fetchPostsGCD { [weak self] result in
            switch result {
            case .failure(let e):
                print(e)
            case .success(let p):
                self?.posts = p
            }
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            self?.myTableView.reloadData()
        }
    }
    
  

 
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func setup(){
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UINib(nibName: "HomeTVC", bundle: nil), forCellReuseIdentifier: "HomeTVC")
        myTableView.register(UINib(nibName: "PostTVC", bundle: nil), forCellReuseIdentifier: "PostTVC")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            5
        }else {
            5
        }
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = myTableView.dequeueReusableCell(withIdentifier: "HomeTVC", for: indexPath) as! HomeTVC
            if let quot = self.quotes{
                cell.configure(n: quot.quotes[indexPath.row].author, d: quot.quotes[indexPath.row].quote)
            }
            
            return cell
        }else {
            let cell = myTableView.dequeueReusableCell(withIdentifier: "PostTVC", for: indexPath) as! PostTVC
            if let posts = self.posts {
                var p = posts.posts[indexPath.row]
                cell.configure(n: p.title, d: p.body, v: String(p.views))
                
            }
            return cell
           
        }
     
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
}
