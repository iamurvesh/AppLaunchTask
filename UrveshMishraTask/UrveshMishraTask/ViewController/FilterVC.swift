//
//  FilterVC.swift
//  UrveshMishraTask
//
//  Created by Urvesh Mishra on 26/08/22.
//

import UIKit

protocol FilterDelegate {
    func filterDidApplied(launchStatus: LaunchStatus, sortedbyName: SortedByName, selectedYear: String)
}

class FilterVC: UIViewController {

    @IBOutlet var btnLaunchSuccess: UIButton!
    @IBOutlet var btnLaunchFailed: UIButton!
    @IBOutlet var btnLaunchBoth: UIButton!
    @IBOutlet var btnSortedAscending: UIButton!
    @IBOutlet var btnSortedDescending: UIButton!
    @IBOutlet var btnSortedNone: UIButton!
    @IBOutlet var txtSearchByYear: UITextField!
    
    var selectedLaunchStatus : LaunchStatus = .both
    var selectedSortedbyName : SortedByName = .both
    var selectedYear = String()
    private var pickerView = UIPickerView()
    private var arrYears = [String]()
    
    var delegate : FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initConfig()
    }
    
}

//MARK: - Init Config Methods
extension FilterVC {
    
    private func initConfig() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.txtSearchByYear.inputView = self.pickerView
        self.addToolBar()
        self.setLaunchSeletion()
        self.setSortedSeletion()
        self.txtSearchByYear.text = self.selectedYear
        let currentYear = NSCalendar.current.dateComponents([.year], from: Date()).year ?? 0
        for item in 1950...currentYear {
            self.arrYears.append("\(item)")
        }
        self.arrYears.reverse()
    }
    
    func addToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dateDidSelected(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.txtSearchByYear.inputAccessoryView = toolBar
    }
    
    @objc func dateDidSelected(_ datePicker: UIDatePicker) {
        self.txtSearchByYear.resignFirstResponder()
    }
    
    private func setLaunchSeletion() {
        self.btnLaunchSuccess.setImage(UIImage(named: "ic_radioUnSelected"), for: .normal)
        self.btnLaunchFailed.setImage(UIImage(named: "ic_radioUnSelected"), for: .normal)
        self.btnLaunchBoth.setImage(UIImage(named: "ic_radioUnSelected"), for: .normal)
        
        if self.selectedLaunchStatus == .success {
            self.btnLaunchSuccess.setImage(UIImage(named: "ic_radio"), for: .normal)
        }
        else if self.selectedLaunchStatus == .failed {
            self.btnLaunchFailed.setImage(UIImage(named: "ic_radio"), for: .normal)
        }
        else {
            self.btnLaunchBoth.setImage(UIImage(named: "ic_radio"), for: .normal)
        }
    }
    
    private func setSortedSeletion() {
        self.btnSortedAscending.setImage(UIImage(named: "ic_radioUnSelected"), for: .normal)
        self.btnSortedDescending.setImage(UIImage(named: "ic_radioUnSelected"), for: .normal)
        self.btnSortedNone.setImage(UIImage(named: "ic_radioUnSelected"), for: .normal)
        
        if self.selectedSortedbyName == .ascending {
            self.btnSortedAscending.setImage(UIImage(named: "ic_radio"), for: .normal)
        }
        else if self.selectedSortedbyName == .descending {
            self.btnSortedDescending.setImage(UIImage(named: "ic_radio"), for: .normal)
        }
        else {
            self.btnSortedNone.setImage(UIImage(named: "ic_radio"), for: .normal)
        }
    }

}

//MARK: - UiBUtton Action
extension FilterVC {
    
    @IBAction func btnApplyFilter(_ sender: Any) {
        self.delegate?.filterDidApplied(launchStatus: self.selectedLaunchStatus, sortedbyName: self.selectedSortedbyName, selectedYear: self.txtSearchByYear.text ?? "")
        self.dismiss(animated: true)
    }
    
    @IBAction func btnClearText(_ sender: UIButton) {
        self.txtSearchByYear.text = ""
    }
    
    @IBAction func btnSortedAscending(_ sender: UIButton) {
        self.selectedSortedbyName = .ascending
        self.setSortedSeletion()
    }
    
    @IBAction func btnSortedNone(_ sender: UIButton) {
        self.selectedSortedbyName = .both
        self.setSortedSeletion()
    }
    
    @IBAction func btnSortedDescending(_ sender: UIButton) {
        self.selectedSortedbyName = .descending
        self.setSortedSeletion()
    }
    
    @IBAction func btnLaunchSuccess(_ sender: UIButton) {
        self.selectedLaunchStatus = .success
        self.setLaunchSeletion()
    }
    
    @IBAction func btnLaunchFailed(_ sender: UIButton) {
        self.selectedLaunchStatus = .failed
        self.setLaunchSeletion()
    }
    
    @IBAction func btnLaunchBoth(_ sender: UIButton) {
        self.selectedLaunchStatus = .both
        self.setLaunchSeletion()
    }
    
}

//MARK: - UIPickerView Delegate Method
extension FilterVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrYears[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtSearchByYear.text = arrYears[row]
    }
}
