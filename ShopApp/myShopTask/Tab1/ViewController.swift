//
//  homeViewController.swift
//  myShopTask
//
//  Created by Manoj 07 on 29/08/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var productArr : [Product]?
    
    func fetchContent(){
        do{
            self.productArr = try context.fetch(Product.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.frame = UIScreen.main.bounds
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchContent()
        
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContent()
    }
    
}



extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        if let productData = productArr?[indexPath.row] {
            cell.productImageView.image = UIImage(data: productData.productImage!)
            
            cell.nameLabel.text = productData.productName
            
            cell.priceLabel.text =  String(describing: productData.productPrice)
            
            cell.categoryLabel.text = productData.productCategory

            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete"){
            
            (action,view,completionhandler) in
                            
            let dataToDelete = self.productArr![indexPath.row]
            
            self.context.delete(dataToDelete)
            
            do{
                try self.context.save()

            }catch{}
            
            self.fetchContent()

        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    
}
