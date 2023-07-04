//
//  BYBTopBrandsVC+Ext.swift
//  PIPSLY
//
//  Created by KiwiTech on 07/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import Foundation
import UIKit
let cellHeight:CGFloat = 185.0

extension BYBTopBrandsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.dataSource?[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBrandCell.reuseIdentifier, for: indexPath) as? TopBrandCell else { return UICollectionViewCell() }
        cell.configureCellWithData(model: model)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.size.width - 60)/2) , height:  cellHeight)
    }
    
}
