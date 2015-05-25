//
//  ViewController.swift
//  SideFixedTableViewHeader
//
//  Created by Mika Yamamoto on 2015/05/25.
//  Copyright (c) 2015年 PGMY. All rights reserved.
//

import UIKit


// MARK: - UITableViewCell
class CellView : UITableViewCell {
    var label:UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label = UILabel(frame: CGRectMake(80, 0, 300, 50))
        self.addSubview(label!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - ViewController
class ViewController: UITableViewController {
    var scrollViewFrame:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(CellView.self, forCellReuseIdentifier: "CellView")
        self.tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "SideFixedTableViewHeader")
        scrollViewFrame = tableView.frame
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CellView = tableView.dequeueReusableCellWithIdentifier("CellView", forIndexPath: indexPath) as! CellView
        
        cell.label!.text = String(indexPath.row)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header:SideFixedTableViewHeader? = tableView.dequeueReusableHeaderFooterViewWithIdentifier("SideFixedTableViewHeader") as? SideFixedTableViewHeader
        if ( nil == header ){
            header = SideFixedTableViewHeader(frame: CGRectZero)
        }
        header?.label?.text = String(section)
        return header
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var section = 0
        var offset = 0.0
        for index in 0..<10 {
            var rect = tableView.rectForSection(index)
            //            println(rect.height)
            offset += Double(rect.height)
            var contentOffset = Double(scrollView.contentOffset.y)
            if ( offset > contentOffset ) {
                section = index
                break
            }
        }
        
        if ( section < 0 || section > 10 ) { return }
        var d = offset - Double(scrollView.contentOffset.y)
        var header:SideFixedTableViewHeader? = tableView.headerViewForSection(section) as? SideFixedTableViewHeader
        var sf = scrollView.frame
        if ( scrollView.contentOffset.y <= 0 ) {
            header?.layoutHeaderViewForScrollViewOffset(CGFloat(0))
        } else if ( d < 100 && d > 0 ) {
            if ( header == nil ) { return }
            header?.layoutHeaderViewForScrollViewOffset(CGFloat(100 - d))
        } else {
            
            header?.layoutHeaderViewForScrollViewOffset(CGFloat(0))
        }

    }
    
    
}

