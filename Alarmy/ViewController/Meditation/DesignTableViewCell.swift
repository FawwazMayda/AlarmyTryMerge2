//  Created by Basit Tri Anggoro on 11/04/20.
//  Copyright © 2020 Basit Tri Anggoro. All rights reserved.
//

import Foundation
import UIKit

class DesignTableViewCell: UITableViewCell {
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var cardView: UIView!
    @IBOutlet var descLbl: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    var mainItem: MainItem?{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        cardView.layer.cornerRadius = 5
        imgView.layer.cornerRadius = 5
        nameLbl.text = mainItem?.name
        descLbl.text = mainItem?.desc
        imgView.image = UIImage(named: mainItem!.image)
    }
}
