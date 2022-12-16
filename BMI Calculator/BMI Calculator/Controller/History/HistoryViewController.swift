//
//  HistoryViewController.swift
//  BMI Calculator
//
//  Created by Brendan Rodrigues 301119016 on 12/15/22.
//  MAPD714 Final Exam.
//

import UIKit

class HistoryViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        }
    }
    
    private let viewModel = HistoryViewModel()
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bindModel(self)
        viewModel.getHistoryList()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension HistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell
        cell.setData(item: viewModel.historyList[indexPath.row])
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @objc func deleteTapped(sender: UIButton) {
        viewModel.deleteItem(sender.tag)
    }
    
}



extension HistoryViewController:HistoryProtocol{
    func historyEmptySuccess() {
        Users.shared.currentUser = nil
        let personalInfoVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPersonalInformationViewController")
        super.setRootViewController(personalInfoVc)
    }
    
    func failure(errorString: String) {
        Utility.showLoaf(message: errorString, state: .error)
    }
    
    func success() {
        tableView.reloadData()
    }
    
    
}


