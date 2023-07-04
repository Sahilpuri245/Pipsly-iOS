//
//  BYBSignupVC+Ext.swift
//  PIPSLY
//
//  Created by KiwiTech on 21/11/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

extension BYBSignupVC: UITableViewDelegate,UITableViewDataSource,SignupNameCellDelegate,SignupGenderCellDelegate{
    
    func didOpenGooglPlacepicker() {
        let placepickerObj = GooglePlaceManager.shared().initializeGooglePlacepicker()
        GooglePlaceManager.shared().delegate = self
        self.present(placepickerObj, animated: true, completion: nil)
    }
    
    func didUpdateSignupfield(inputString: String?, cellSubtype: SignupCellSubType) {
        guard let inputValue = inputString else { return }
        updateDataSource(cellSubType: cellSubtype, inputValue: inputValue)
        switch cellSubtype {
        case .name: signupObj.name = inputValue.trimmingCharacters(in: .whitespaces)
        case .email: signupObj.email = inputValue.trimmingCharacters(in: .whitespaces)
        case .password: signupObj.password = inputValue.trimmingCharacters(in: .whitespaces)
        case .gender: signupObj.gender = inputValue
        case .birthday: signupObj.dob = inputValue
        case .address:break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        if  model.cellType == .nameCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? SignupNameCell else {
                return UITableViewCell()
            }
            cell.configureCellWithData(model: model)
            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? SignupGenderCell else {
                return UITableViewCell()
            }
            cell.configureCellWithData(model: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.row]
        return model.cellHeight
    }
    
}
