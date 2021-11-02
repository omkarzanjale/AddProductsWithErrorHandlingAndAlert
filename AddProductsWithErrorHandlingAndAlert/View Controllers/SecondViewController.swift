//
//  SecondViewController.swift
//  Products
//
//  Created by Mac on 16/09/21.
//

import UIKit

protocol SecondViewControllerProtocol:class {
    func passedData(_ category: String?,_ name: String?,_ price: Int)
}

class SecondViewController: UIViewController {

    @IBOutlet weak var categoryTextField:UITextField!
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var priceTextField:UITextField!

    weak var secondViewControllerDelegate: SecondViewControllerProtocol?
    
    enum TextFieldInputeErrors: Error {
        case InvalidCategoryError
        case EmptyNameError
        case InvalidPriceError
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Product"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnAction))
    }
    
    private func showAlert(message: String, title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func validateTextFields() throws {
        guard let category = categoryTextField.text else {
            return
        }
        guard let name = nameTextField.text else {
            return
        }
        guard let priceStr = priceTextField.text else {
            return
        }
        let price = Int(priceStr) ?? 0
        if category=="Fashion"||category=="FASHION"||category=="fashion"||category=="ELECTRIC"||category=="Electric"||category=="electric"{
            if name.isEmpty == false {
                if price >= 99 {
                    secondViewControllerDelegate?.passedData(category, name, price)
                    navigationController?.popViewController(animated: true)
                }else{
                    throw TextFieldInputeErrors.InvalidPriceError
                }
            } else {
                throw TextFieldInputeErrors.EmptyNameError
            }
        } else {
            throw TextFieldInputeErrors.InvalidCategoryError
        }
    }
    
    @IBAction func doneBtnAction() {
        do {
            try validateTextFields()
        } catch TextFieldInputeErrors.InvalidCategoryError {
            showAlert(message: "Category type must be Electric or Fashion only.", title: "Warning!!!")
        } catch TextFieldInputeErrors.EmptyNameError {
            showAlert(message: "Please Enter Name.", title: "Warning!!!")
        } catch TextFieldInputeErrors.InvalidPriceError {
            showAlert(message: "Price must be greater than 99.", title: "Warning!!!")
        } catch {
            showAlert(message: "Something went wrong!,Try again.", title: "Warning!!!")
        }
    }
}
//
//MARK: UITextFieldDelegate
//
extension SecondViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        false
    }
    
}
