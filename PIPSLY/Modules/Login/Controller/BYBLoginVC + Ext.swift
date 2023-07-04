//
//  BYBLoginVC + Ext.swift
//  PIPSLY
//
//  Created by KiwiTech on 29/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

extension BYBLoginVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.row]
        if model.cellType == .loginCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCell.reuseIdentifier, for: indexPath) as? LoginCell else { return UICollectionViewCell() }
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserTypeCell.reuseIdentifier, for: indexPath) as? UserTypeCell else { return UICollectionViewCell() }
            cell.delegate = self
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height:  collectionView.frame.size.height)
    }
    
}
