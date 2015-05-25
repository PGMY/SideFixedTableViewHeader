//
//  SideFixedTableViewHeader.swift
//  SideFixedTableViewHeader
//
//  Created by Mika Yamamoto on 2015/05/25.
//  Copyright (c) 2015年 PGMY. All rights reserved.
//

import UIKit

class SideFixedTableViewHeader: UITableViewHeaderFooterView {
    var fixedView:UIView?
    var label:UILabel?
    var orgFrame:CGRect?
    var orgOriginY:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        orgFrame = frame
        fixedView = UIView(frame: CGRectMake(0, 0, 60, 100))
        fixedView!.backgroundColor = UIColor.greenColor()
        fixedView!.layer.borderColor = UIColor.blackColor().CGColor
        fixedView!.layer.borderWidth = 1
        self.addSubview(fixedView!)
        
        label = UILabel(frame: CGRectMake(0, 0, 60, 100))
        
        fixedView!.addSubview(label!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        orgOriginY = self.frame.origin.y
    }
    
    func layoutHeaderViewForScrollViewOffset(offset:CGFloat) {
        var frame = fixedView!.frame
        frame.origin.y = -offset
        fixedView!.frame = frame
    }
}