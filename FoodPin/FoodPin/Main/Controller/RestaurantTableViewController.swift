//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 11/8/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController,AddRestaurantProtocol,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    var restaurants:[FoodPinRestaurant] = []
    var searchController:UISearchController!
//    var searchResults:[fo]
    var searchResult:[FoodPinRestaurant] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let pageViewController =
            storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as?
            PageViewController {
            self.presentViewController(pageViewController, animated: false, completion: nil)
        }
        
        searchController = UISearchController(searchResultsController : nil)
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 80.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        
        
      
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
        getDataFromCoreData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if searchController.active {
            return searchResult.count
        }
        return self.restaurants.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        
        // Configure the cell...
        let restaurant = (searchController.active) ? searchResult[indexPath.row] : restaurants[indexPath.row]
       
        cell.nameLabel.text = restaurant.name
//        cell.thumbnailImageView.image = UIImage(data: restaurant.image!)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.favorIconImageView.hidden = !restaurant.isVisited.boolValue
   
        // Circular image
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
   
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        //如果搜索条在使用的时候不允许滑动删除
        if searchController.active {return false}
        return true
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction] {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
            let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
            }
        )
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: {
            (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            // Delete the row from the data source
//            self.restaurants.removeAtIndex(indexPath.row)
            self.deleteDataFromCoreData(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)

            }
        )

        deleteAction.backgroundColor = UIColor(red: 237.0/255.0, green: 75.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1.0)

        return [deleteAction, shareAction]
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.restaurant = (searchController.active) ? searchResult[indexPath.row] : restaurants[indexPath.row]
            }
            
        }
       
    }
    
    //MARK: - 获取数据
    func getDataFromCoreData() {
        
        if let managedObjcetContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            let fetchRequest = NSFetchRequest(entityName:"Restaurant")
            
            do {
                let fetchedObjects = try managedObjcetContext.executeFetchRequest(fetchRequest)
                print("fetchedObjects == \(fetchedObjects)")
//                restaurants.removeAll()
                restaurants = fetchedObjects as![FoodPinRestaurant]
//                restaurants = restaurants.reverse()
//         
                self.tableView.reloadData()
            }catch {
                fatalError("不能保存:\(error)")
            }
        }
    }
    //MARK: - 删除数据
    func deleteDataFromCoreData(index:NSInteger) {
        if let managedObjcetContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {

                managedObjcetContext.deleteObject(restaurants[index])
                do {
                    try managedObjcetContext.save()
                }catch {
                    fatalError("不能保存:\(error)")
                }
                restaurants.removeAtIndex(index)

        }
    }
    
    //MARK: - SearchBarController
    func filterContentForSearchText(searchText:String) {
        searchResult = restaurants.filter({ (restaurant:FoodPinRestaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText,options: NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil
        })
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText!)
        self.tableView.reloadData()
    }
    func saveRestaurant(restaurant: FoodPinRestaurant) {
        self.restaurants.insert(restaurant, atIndex: 0)
        self.tableView.reloadData()
        
    }
    
    //其他页面返回方法
    @IBAction func unwindtoHomeScreen(segue:UIStoryboardSegue) {
        
    }

    


}
