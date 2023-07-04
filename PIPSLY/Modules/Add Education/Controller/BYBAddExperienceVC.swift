//
//  BYBAddExperienceVC.swift
//  PIPSLY
//
//  Created by KiwiTech on 20/12/18.
//  Copyright © 2018 PIPSLY. All rights reserved.
//

import UIKit

class BYBAddExperienceVC: UIViewController {

    @IBOutlet weak var addExperience: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    
    var addButton: UIButton?
    var isPickerOpen = false
    var arrayOfYears = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: Double(0.2), animations: {
            self.bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        })
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != addExperience {
            self.dismiss(animated: true, completion: nil)
        }
    }

    //MARK: private methods
    private func setupView()  {
        self.heightConstraint?.constant = 394
        tblView.rowHeight = 56
        tblView.tableFooterView = self.getFooterView()
        makeArrayOfYears()
        configureCell()
    }
    
    private func makeArrayOfYears() {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        for i in (year-25..<year+25) {
            arrayOfYears.append("\(i)")
        }
        print(arrayOfYears)
    }
    
    // configure cell identifier
    func configureCell() {
        tblView?.register(UINib(nibName: TableViewCellIdentifier.kBYBAddExperienceTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.kBYBAddExperienceTableViewCell.rawValue)
        
    }
    
    func getFooterView() -> UIView {
        let view: UIView = UIView.init(frame: CGRect(x:0,y:0,width:self.view.frame.size.width, height:65))
        view.backgroundColor = UIColor.white
        
        //Create Add button
        addButton = UIButton.init(type: UIButton.ButtonType.custom)
        addButton?.frame = CGRect(x: 20, y: 10, width: self.view.frame.size.width-40, height: 55)
        addButton?.titleLabel?.font = UIFont(name: "Metropolis-Bold", size: 16)
        addButton?.setTitle("Add", for: UIControl.State.normal)
        addButton?.setTitleColor(UIColor.colorWithRGBA(redValue: 255, greenValue: 255, blueValue: 255, alpha: 0.6), for: .normal)
        addButton?.setBackgroundImage(UIImage(named: "button"), for: .normal)
        addButton?.isUserInteractionEnabled = false
        addButton?.addTarget(self, action: #selector(tapOnAddButton), for: .touchUpInside)
        view.addSubview(addButton!)
        
        return view
    }
    
    //MARK:- Action Events
    @objc func tapOnAddButton(sender: UIButton?) {
        
    }
    
    @objc func tapOnDateButton(sender: UIButton?) {
        isPickerOpen = !isPickerOpen
        tblView.reloadData()
    }
    
}

//MARK: tableView delegate & dataSource
extension BYBAddExperienceVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier:TableViewCellIdentifier.kBYBAddExperienceTableViewCell.rawValue) as? AddExperienceCell else{
            return UITableViewCell()
        }
        cell.dateView.isHidden = true
        cell.txtField.isHidden = false
        if indexPath.row == 3 {
            cell.dateView.isHidden = false
            cell.txtField.isHidden = true
            cell.startDateBtn.addTarget(self, action: #selector(tapOnDateButton), for: .touchUpInside)
            cell.endDateBtn.addTarget(self, action: #selector(tapOnDateButton), for: .touchUpInside)
        }
        switch indexPath.row {
        case 0:
            cell.txtField.placeholder = "Designation?"
        case 1:
            cell.txtField.placeholder = "Business?"
        case 2:
            cell.txtField.placeholder = "Location?"
        default:
            break
        }
        
        if isPickerOpen && indexPath.row == 3 {
            tblView.rowHeight = 56+140
            self.heightConstraint?.constant = 394+140
            cell.pickerHeightConstraint.constant = 140
            cell.pickerView.delegate = self
            cell.pickerView.dataSource = self
            cell.pickerView.selectedRow(inComponent: 0)
        }
        else {
            tblView.rowHeight = 56
            self.heightConstraint?.constant = 394
            cell.pickerHeightConstraint.constant = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: UIPickerView delegate & dataSource
extension BYBAddExperienceVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrayOfYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return arrayOfYears[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        var label:UILabel
        
        if let v = view as? UILabel{
            label = v
        }
        else{
            label = UILabel()
        }
        
        if let selectedLbl = pickerView.view(forRow: row, forComponent: 0) as? UILabel {
            selectedLbl.textColor = UIColor.green
        }
        else {
            label.textColor = UIColor.black
        }
        
        
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 16)
        label.text = arrayOfYears[row]
        
        return label
    }
}
