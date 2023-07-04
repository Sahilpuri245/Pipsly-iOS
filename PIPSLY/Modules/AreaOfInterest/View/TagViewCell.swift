//
//  TagViewCell.swift
//  PIPSLY
//
//  Created by KiwiTech on 05/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit
protocol TagViewCellDelegate:class {
    func didSelectTags(selectedTags:[Int]?, isProceed:Bool)
}

class TagViewCell: BaseTableCell,TagListViewDelegate {
    
    @IBOutlet weak var tagView: TagListView?
    weak var delegate:TagViewCellDelegate?
    var datasource = [InterestCategoryModel]()
    var arrSelectedCategory = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagView?.delegate  = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellWithData(list:[InterestCategoryModel]?)  {
        guard let array = list else {return}
        datasource = array
        tagView?.textFont = UIFont.init(name: "Metropolis-Bold" , size: 14.0)!
        setTag(list: array)        
        tagView?.alignment = .left
        tagView?.cornerRadius = 5.0
    }
    
    func setTag(list:[InterestCategoryModel])  {
        for (_, element) in list.enumerated() {
            if let tagView = tagView?.addTag(element.name!) {
                tagView.titleLabel?.tag = element.id!
            }
        }
    }
    
    //MARK: TagView Delegates
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected = !tagView.isSelected
        if tagView.isSelected {
            if let tag = tagView.titleLabel?.tag {
                arrSelectedCategory.append(tag)
            }
        } else {
            let id = arrSelectedCategory.filter{ $0 == tagView.titleLabel?.tag }.first
            for (index, element) in arrSelectedCategory.enumerated() {
                if id == element {
                    arrSelectedCategory.remove(at: index)
                    break
                }
            }
        }
        let isSelected = sender.tagViews.filter { $0.isSelected == true }
        if !isSelected.isEmpty {
            delegate?.didSelectTags(selectedTags: arrSelectedCategory, isProceed: true)
        } else {
            delegate?.didSelectTags(selectedTags: arrSelectedCategory, isProceed: false)
        }

    }

}
