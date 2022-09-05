//
//  addCategoryViewController.swift
//  myShopTask
//
//  Created by Manoj 07 on 27/08/22.
//

import UIKit
import CoreData

class addCategoryViewController : UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var allCategory : [Category]?
    
    func fetchCategory(){
        do{
            self.allCategory = try context.fetch(Category.fetchRequest())
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


    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 10, y: 160, width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width-20)
        imageView.image = nil
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 5
        imageView.isUserInteractionEnabled = true
        return imageView

    }()

    let addButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.frame = CGRect(x:50, y: 160 + UIScreen.main.bounds.width ,width: 100, height: 50)
        button.setTitle("ADD", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(AddtoCoreData), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchCategory()
        
        view.backgroundColor = .white
        title = "Add Category"
        
        addButton.center.x = view.center.x
        
        
        view.addSubview(nameTextField)
        view.addSubview(imageView)
        view.addSubview(addButton)
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewdidtap))
        imageView.addGestureRecognizer(tap)

    }
    
    @objc func imageViewdidtap(){
        let vc = UIImagePickerController()
        vc.sourceType = .savedPhotosAlbum
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        imageView.backgroundColor = .green
        
    }
    
    @objc func AddtoCoreData(){
        
        if (self.nameTextField.text == nil || self.imageView.image == nil){
            
            let alert = UIAlertController(title: "InputField Empty", message: "Add all the fields", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alert.addAction(dismiss)
            
            present(alert, animated: true, completion: nil)

        }else{
            let newinput = Category(context: self.context)
            
            newinput.categoryName = nameTextField.text!
            
            let png = self.imageView.image!.pngData()
            newinput.categoryImage = png
            
            do{
                try context.save()
            }catch let error {
                print(error.localizedDescription)
            }
            
            self.fetchCategory()
            
            addButton.backgroundColor = .gray
            
            navigationController?.popViewController(animated: true)
            
        }
    }
    
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

