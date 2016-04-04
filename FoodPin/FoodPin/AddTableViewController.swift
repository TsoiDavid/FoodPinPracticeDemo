//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by TsoiKaShing on 16/4/3.
//  Copyright © 2016年 AppCoda. All rights reserved.
//
protocol AddRestaurantProtocol {
    
    func saveRestaurant(restaurant:Restaurant)
}
import UIKit

class AddTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var typeTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var yesButton: UIButton!
    
    public var delegate:AddRestaurantProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                //.Camera 调用照相机
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        headImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        headImage.contentMode = UIViewContentMode.ScaleAspectFill
        headImage.clipsToBounds = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if nameTextField.text?.characters.count > 0 && typeTextField.text?.characters.count > 0 && locationTextField.text?.characters.count > 0  {
            let restaurant = Restaurant(name: nameTextField.text!, type: typeTextField.text!, location: locationTextField.text!, image:"", isVisited: true)
            restaurant.locationImage = headImage.image
            
            self.delegate?.saveRestaurant(restaurant)
            
            self.performSegueWithIdentifier("unwindToHomeScreen", sender: self)
            
        }else {
            let alter = UIAlertController(title: "保存失败", message: "你提交的信息不完整，请填写完整再保存", preferredStyle:.Alert)
            let alterAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
            alter.addAction(alterAction)
            presentViewController(alter, animated: true, completion: nil)
            
        }
    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
