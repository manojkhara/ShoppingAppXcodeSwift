//
//  addProductViewController.swift
//  myShopTask
//
//  Created by Manoj on 07 on 27/08/22.
//

import UIKit
import CoreData

class addProductViewController: UIViewController {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var allCategory : [Category]?
    var allProducts : [Product]?
    
    func fetchContent(){
        do{
            self.allCategory = try context.fetch(Category.fetchRequest())
            self.allProducts = try context.fetch(Product.fetchRequest())
            
            DispatchQueue.main.async {
                self.categoryPicker.reloadAllComponents()
            }
        }
        catch{}
    }

    
    let nameTextField : UITextField = {
        let textfield = UITextField()
        textfield.text = nil
        textfield.placeholder = "Name"
        textfield.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        textfield.frame = CGRect(x: 10, y: 80, width: UIScreen.main.bounds.width-20, height: 50)
        textfield.layer.cornerRadius = 5
        return textfield
    }()
    
    var categoryPicker = UIPickerView()
    
    let categoryTextField : UITextField = {
        let textfield = UITextField()
        textfield.text = nil
        textfield.placeholder = "Add Category"
        textfield.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        textfield.frame = CGRect(x: 10, y: 150, width: UIScreen.main.bounds.width-20, height: 50)
        textfield.layer.cornerRadius = 5
        return textfield
    }()
    
    let priceTextField : UITextField = {
        let textfield = UITextField()
        textfield.text = nil
        textfield.placeholder = "Price"
        textfield.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        textfield.frame = CGRect(x: 10, y: 220, width: UIScreen.main.bounds.width-20, height: 50)
        textfield.layer.cornerRadius = 5
        return textfield
    }()

    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 10, y: 290, width: UIScreen.main.bounds.width-20, height: 200)
        imageView.image = UIImage(named: "ic_add_img")
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 5
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    
    let addButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.frame = CGRect(x:50, y:510 ,width: 100, height: 50)
        button.setTitle("ADD", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Product"
        
        fetchContent()
    
        categoryPicker.frame = CGRect(x: 10, y: 0, width: view.frame.width-20, height: 200)
        categoryPicker.backgroundColor = .darkGray
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        categoryTextField.inputAccessoryView = self.categoryPicker
        addButton.center.x = view.center.x
                
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewDidtap))
        imageView.addGestureRecognizer(tap)
        
        self.nameTextField.text = nil
        self.categoryTextField.text = nil
        self.priceTextField.text = nil
        self.imageView.image = nil
        
        view.addSubview(nameTextField)
        view.addSubview(categoryTextField)
        view.addSubview(priceTextField)
        view.addSubview(imageView)
        view.addSubview(addButton)

    }
    
    @objc func imageViewDidtap(){
        let vc = UIImagePickerController()
        vc.sourceType = .savedPhotosAlbum
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        imageView.backgroundColor = .green
    }
    
    @objc func addButtonTapped(){
        
        if (self.nameTextField.text == nil || self.categoryTextField.text == nil || self.priceTextField.text == nil || self.imageView.image == nil) {
            
            let alertController = UIAlertController(title: "Empty Fields", message: "Fill all Fields", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertController.addAction(dismiss)
            present(alertController, animated: true)
            
        }else{
            
            let newInput = Product(context: self.context)
            newInput.productName = self.nameTextField.text!
            newInput.productCategory = self.categoryTextField.text!
            newInput.productPrice = Double(self.priceTextField.text!)!
            
            let png = self.imageView.image?.pngData()
            newInput.productImage = png
            
            do{
                try self.context.save()
            }
            catch{
                print(error.localizedDescription)
            }

            self.fetchContent()
            addButton.backgroundColor = .gray
            
            navigationController?.popViewController(animated: true)
        }
        
    }
    
}


extension addProductViewController : UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }

}



extension addProductViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCategory?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return allCategory?[row].categoryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        categoryTextField.text = allCategory?[row].categoryName
        categoryTextField.resignFirstResponder()

    }

}

