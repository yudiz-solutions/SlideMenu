//
//  Subclasses.swift
//  Carepack
//
//  Created by Yudiz Solutions Pvt.Ltd. on 23/02/16.
//  Copyright © 2016 Yudiz Solution Pvt Ltd. All rights reserved.
//

import UIKit

// MARK: - Useful Classes
class GenericCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var imgv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


class GenericTableViewCell: ConstrainedTableViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var imgv: UIImageView!
    @IBOutlet var imgBg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

class GenericTableViewCell1: ConstrainedTableViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    @IBOutlet var imgv: UIImageView!
    @IBOutlet var imgBg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            backgroundColor    = UIColor.white.withAlphaComponent(0.45)
        } else {
            backgroundColor = UIColor.clear
        }
    }
    
}

class PushWithoutAnimationSegue: UIStoryboardSegue {
    override func perform() {
        let svc =  source
        svc.navigationController?.pushViewController(destination , animated: false)
    }
    
}

class FullRoundedCornerView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.bounds.size.height/2
        self.layer.masksToBounds = true
    }
}

class WhitePlaceHolderTextFiled: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        //        self.tintAdjustmentMode = .Automatic
        self.layoutIfNeeded()
        self.tintColor =  UIColor.white
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName :  UIColor.white])
    }
}

class InputTextFiled: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.tintColor =  UIColor.white
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName :  UIColor.white.withAlphaComponent(0.35)])
    }
}


