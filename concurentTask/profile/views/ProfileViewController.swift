//
//  ProfileViewController.swift
//  omartask2
//
//  Created by Omar on 07/06/2026.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var sname: UILabel!
    @IBOutlet weak var profileTV: UITableView!
    
    var user: User?
    var posts: PostsResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        Task {
//             try await getuserAndPostsModern()
//        }
        getuserAndPostsGCD()
       
    }
    func setup(){
        profileTV.dataSource = self
        profileTV.delegate = self
        profileTV.register(UINib(nibName: "PostTVC", bundle: nil), forCellReuseIdentifier: "PostTVC")
    }
   
    //async version
    func getuserAndPostsModern() async throws {
    
        let user: User
        do {
            user = try await fetchUser()
        } catch {
            print(error.localizedDescription)
            return
        }
       
        await MainActor.run {
            self.user = user
            self.bindUserData()
        }
        
            do {
            let posts = try await fetchPostsOfUser(userId: user.id)
           
            await MainActor.run {
                self.posts = posts
                self.profileTV.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    //gcd version
    func getuserAndPostsGCD(){
        fetchUserGCD { [weak self] (user) in
            switch user {
            case .success(let user):
                
                fetchPostsOfUserGCD(userId: user.id) { [weak self] result in
                    switch result {
                    case .success(let result):
                        
                        DispatchQueue.main.async {
                            self?.user = user
                            self?.posts = result
                            self?.bindUserData()
                            self?.profileTV.reloadData()
                        }
                        
                    case .failure(let e):
                        print(e.localizedDescription)
                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    func bindUserData(){
        self.fname.text = user?.firstName ?? ""
        self.sname.text = user?.lastName ?? ""
        self.email.text = user?.email ?? ""
        self.role.text = user?.role ?? ""
        self.country.text = user?.address.country ?? ""
        self.department.text = user?.company.department ?? ""
    }

}





extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTV.dequeueReusableCell(withIdentifier: "PostTVC", for: indexPath) as! PostTVC
        let p = posts?.posts[indexPath.row]
        cell.configure(n: p?.title ?? "", d: p?.body ?? "", v: String(p?.views ?? 0 ))
        return cell
    }

    
}
