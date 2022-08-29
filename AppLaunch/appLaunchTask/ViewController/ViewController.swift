//
//  ViewController.swift
//  UrveshMishraTask
//
//  Created by Urvesh Mishra on 26/08/22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlet Declaration
    @IBOutlet var tblView: UITableView!
    @IBOutlet var btnFilter: UIButton!
    
    //MARK: - Varible Declaration
    private var companyDetails: Company?
    private var arrLaunchesResponse = [launches]()
    private var arrLaunches = [launches]()
    private var selectedLaunchStatus : LaunchStatus = .both
    private var selectedSortedbyName : SortedByName = .both
    private var selectedYear = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initConfig()
    }

    @IBAction func btnFilter(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as? FilterVC {
            vc.delegate = self
            vc.selectedLaunchStatus = self.selectedLaunchStatus
            vc.selectedSortedbyName = self.selectedSortedbyName
            vc.selectedYear = self.selectedYear
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

//MARK: - Init Config Methods
extension ViewController {
    
    private func initConfig() {
        self.tblView.registerCell(withNib: "CompanyDetailsTCell")
        self.tblView.registerCell(withNib: "LaunchesTCell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.getCompanyDetails()
        self.getLaunchesDetails()        
    }
}

//MARK: - UiTableview Delegate & DataSource Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return arrLaunches.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyDetailsTCell", for: indexPath) as? CompanyDetailsTCell else { return UITableViewCell() }
        
            if let company = self.companyDetails {
                cell.lblCompanyDetails.text = "\(company.name) was founded by \(company.founder) in \(company.founded). It has now \(company.employees) employees, \(company.launchSites) launch sites, and is valued at USD \(company.valuation)"
            }
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchesTCell", for: indexPath) as? LaunchesTCell else { return UITableViewCell() }
            if self.arrLaunches.indices ~= indexPath.row {
                cell.dataBind(obj: self.arrLaunches[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "COMPANY"
        }
        return "LAUNCHES"
    }
}

//MARK: - API Calling
extension ViewController {
    
    private func getCompanyDetails() {
        HttpRequestManager.sharedInstance.getRequest(service: "company", showLoader: true) { error, response in
            if error != nil {
                self.showAlert(error.debugDescription, message: "")
            }
            else {
                let decoder = JSONDecoder()
                if let data = response, let company = try? decoder.decode(Company.self, from: data) {
                    self.companyDetails = company
                    self.tblView.reloadData()
                }
            }
        }
    }
    
    private func getLaunchesDetails() {
        HttpRequestManager.sharedInstance.getRequest(service: "launches", showLoader: true) { error, response in
            if error != nil {
                self.showAlert(error.debugDescription, message: "")
            }
            else {
                let decoder = JSONDecoder()
                if let data = response, let arrLunches = try? decoder.decode([launches].self, from: data) {
                    self.arrLaunchesResponse = arrLunches
                    self.arrLaunches = arrLunches
                    self.tblView.reloadData()
                }
            }
        }
    }

}

extension ViewController : FilterDelegate {
    
    func filterDidApplied(launchStatus: LaunchStatus, sortedbyName: SortedByName, selectedYear: String) {
        self.selectedSortedbyName = sortedbyName
        self.selectedLaunchStatus = launchStatus
        self.selectedYear = selectedYear
        
        var tempArr = [launches]()
        if launchStatus == .both {
            tempArr = self.arrLaunchesResponse
        }
        else if launchStatus == .success {
            tempArr = self.arrLaunchesResponse.filter({$0.success == true})
        }
        else {
            tempArr = self.arrLaunchesResponse.filter({$0.success == false})
        }
        if sortedbyName == .ascending {
            tempArr = tempArr.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }
        else if sortedbyName == .descending {
            tempArr = tempArr.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedDescending }
        }
        
        if selectedYear != "" {
            tempArr = tempArr.filter({Calendar.current.dateComponents([.year], from: $0.dateUtc.getDateFromString(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")).year == Int(selectedYear)})
        }
        
        self.arrLaunches = tempArr
        self.tblView.reloadData()
    }
    
}
