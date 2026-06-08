//
//  HomeTVC.swift
//  omartask2
//
//  Created by Omar on 06/06/2026.
//

import UIKit

class HomeTVC: UITableViewCell {

    @IBOutlet weak var view: UIStackView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    func configure(n: String, d: String){
        self.name.text = n
        self.details.text = d
    }
    
}
