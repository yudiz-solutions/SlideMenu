//
//  MenuCells.swift
//  AussieFood
//
//  Created by Yudiz Solutions Pvt.Ltd. on 12/09/16.
//  Copyright © 2016 Yudiz Solutions Pvt.Ltd. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Menu Profile Cell
class MenuProfileCell: ConstrainedTableViewCell
{
    @IBOutlet var imgvProfile: UIImageView!
    @IBOutlet var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
//MARK: - Menu Item Cell

class MenuItemCell: ConstrainedTableViewCell
{
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblLine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareToFillData(_ menu:MenuSpecific,index : Int){
        self.lblTitle.text = menu.items[index].rawValue
     
        let isSelected = menu.items[index] == menu.selectedItem
        
        self.lblTitle.alpha = isSelected ? menu.selectedAlpha : menu.normalAlpha
        self.lblTitle.font  = isSelected ? menu.selectedFont : menu.normalFont
    }
}
