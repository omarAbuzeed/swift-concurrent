//
//  PostTVC.swift
//  omartask2
//
//  Created by Omar on 07/06/2026.
//

import UIKit

class PostTVC: UITableViewCell {

    @IBOutlet weak var view: UIStackView!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
            }
    func configure(n: String, d: String, v: String){
        views.text = v
        details.text = d
        name.text = n
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
