//
//  categoryViewController.swift
//  myShopTask
//
//  Created by Manoj 07 on 27/08/22.
//

import UIKit
import CoreData

class categoryViewController: UIViewController {
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryArr : [Category]?
    
    func fetchContent(){
        
        do{
            self.categoryArr = try context.fetch(Category.fetchRequest())
            
            DispatchQueue.main.async {
                self.collectionview.reloadData()
            }
        }
        
        catch{}
        
        
    }
    
//    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

//    var collectionview = UICollectionView()
    
    let collectionview:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchContent()
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: view.frame.width/2 - 15, height: view.frame.width/2 - 15)
        
        
//        let collectionview = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
//        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        collectionview.setCollectionViewLayout(layout, animated: true)
        
        collectionview.frame = view.bounds
        collectionview.collectionViewLayout = layout
        collectionview.delegate = self
        collectionview.dataSource = self
        
        collectionview.register(categoryCollectionViewCell.self, forCellWithReuseIdentifier: categoryCollectionViewCell.identifier)
        
        view.addSubview(collectionview)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContent()
    }
    
}



extension categoryViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewCell.identifier, for: indexPath) as! categoryCollectionViewCell
                
        if let categoryData = categoryArr?[indexPath.row] {
            cell.categoryImageView.image = UIImage(data: categoryData.categoryImage!)
            cell.nameLabel.text = categoryData.categoryName
        }

        cell.button.tag = indexPath.row
        
        cell.button.addTarget(self, action: #selector(removeCategory(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func removeCategory(_ sender : UIButton){
        
        let alertController = UIAlertController(title: "Delete?", message: "Deletion Will be Permanent", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { Action in
            
            self.deleteData(sender.tag)

        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
        
        
    }
    
    func deleteData(_ tag : Int){
        
        let dataToDelete = self.categoryArr![tag]
        
        self.context.delete(dataToDelete)
        
        do{
            try self.context.save()

        }catch{}
        
        self.fetchContent()

    }

    
}
