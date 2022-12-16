//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Brendan Rodrigues 301119016 on 12/15/22.
//  MAPD714 Final Exam
//

import UIKit
enum InfoScreenType{
    case add
    case edit
}


class AddPersonalInformationViewController: UIViewController {

    
    @IBOutlet private weak var nameTextField:UITextField!
    @IBOutlet private weak var ageTextField:UITextField!
    @IBOutlet private weak var genderTextField:UITextField!
    @IBOutlet private weak var weightTextField:UITextField!
    @IBOutlet private weak var heightTextField:UITextField!
    
    
    @IBOutlet private weak var imperialBtn:UIButton!
    @IBOutlet private weak var MetricBtn:UIButton!
    
    @IBOutlet weak var backBtn: UIButton!{
        didSet{
            backBtn.isHidden = InfoScreenType == .add
        }
    }
    @IBOutlet weak var doneBtn: UIButton!{
        didSet{
            doneBtn.setTitle(InfoScreenType == .add ? "Done" : "Update", for: .normal)
        }
    }
    
    
    var selectedUnit = 0
    private let viewModel = AdddPersonalInformationViewModel()
    var InfoScreenType:InfoScreenType = .add
    var profileUpdated:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bindViewModel(self)
        setInitialData()
    }
    
    
    @IBAction func unitChangeTapped(_ sender:UIButton){
        selectedUnit = sender.tag
        updateDesignForButton()
    }
    
    func updateDesignForButton(){
        imperialBtn.setImage( selectedUnit == 0 ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle") , for: .normal)
        MetricBtn.setImage( selectedUnit == 1 ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle") , for: .normal)
        
        weightTextField.text = ""
        heightTextField.text = ""
        
        
        weightTextField.placeholder = selectedUnit == 0 ? "Pounds" : "Kilgram"
        heightTextField.placeholder = selectedUnit == 0 ? "Inches" : "Meter"
    }
    
    
    
    
    
    @IBAction func saveTapped(_ sender:UIButton){
        
        
        
        let userModel = UserModel.init(
            name: nameTextField.text ?? "",
            age: ageTextField.text ?? "",
            gender: genderTextField.text ?? "",
            isMetric: selectedUnit == 1,
            weight: Double(weightTextField.text ?? "-1") ?? -1,
            height: Double(heightTextField.text ?? "-1") ?? -1,
            bmi: 0)
        
        
        viewModel.userModel = userModel
        let isInputValid = viewModel.isInputValid()
        if isInputValid{
            InfoScreenType == .add ? viewModel.savePersonalInformation() : viewModel.updatePersonalInformation()
        }
    }
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // set data
    func setInitialData(){
        if InfoScreenType == .add { return }
        
        nameTextField.text = Users.shared.currentUser?.name ?? ""
        ageTextField.text = Users.shared.currentUser?.age ?? ""
        genderTextField.text = Users.shared.currentUser?.gender ?? ""
        
        selectedUnit = Users.shared.currentUser?.isMetric ?? false == true ? 1 : 0
        
        weightTextField.text = "\(Users.shared.currentUser?.weight ?? 0)"
        heightTextField.text = "\(Users.shared.currentUser?.height ?? 0)"
        
    }
    


}


extension AddPersonalInformationViewController:AdddPersonalInformationProtocol{
    func success(_ successMessage: String) {
        Utility.showLoaf(message: successMessage, state: .success)
        
        if InfoScreenType == .add{
            let dashboardVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController")
            self.navigationController?.pushViewController(dashboardVc, animated: true)
        }else{
            self.profileUpdated?()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func success() {
        
    }
    
    func failure(_ errorString: String) {
        Utility.showLoaf(message: errorString, state: .error)
    }
    
    
}
