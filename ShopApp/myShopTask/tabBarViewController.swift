//
//  ViewController.swift
//  myShopTask
//
//  Created by Manoj 07 on 27/08/22.
//

import UIKit

class tabBarViewController: UITabBarController, UITabBarControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.delegate = self
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "My Shop"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_more"), style: .plain, target: self, action: #selector(moreOptions))
        
        let homeTab = ViewController()
        homeTab.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_home_inac"), selectedImage: UIImage(named: "ic_home"))
        
        let categoryTab = categoryViewController()
        categoryTab.tabBarItem = UITabBarItem(title: "Category", image: UIImage(named: "ic_cat_inac"), selectedImage: UIImage(named: "ic_cat"))
        
        self.setViewControllers([homeTab,categoryTab], animated: true)

    }
    
    @objc func moreOptions(){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let addCategory = UIAlertAction(title: "Add Category", style: .default, handler: {action in
            self.gotoAddCategoryVC()
        })
        
        let addProduct = UIAlertAction(title: "Add Product", style: .default, handler: { action in
            self.gotoAddProductVC()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(addCategory)
        alert.addAction(addProduct)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    func gotoAddCategoryVC(){
        let vc = addCategoryViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }

    func gotoAddProductVC(){
        let vc = addProductViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
