//
//  PageViewController.swift
//  FoodPin
//
//  Created by admin on 16/4/5.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {

    var pageHeadings = ["Personalize","Locate","Discover"]
    var pageImages = ["homei","mapintro","fiveleaves"]
    var pageSubHeadings = ["Pin your favourite restaurants and create your own food guide","Search and locate your favourite restaurant on Maps","Find restaurants pinned by your friends and other foodies around the world"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       delegate = self
        dataSource = self
        if let startingViewController = self.viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
       print("before index 1== \(index)")
        index--
        print("before index 2== \(index)")
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        print("after index1 == \(index)")
        index++
        print("after index2 == \(index)")
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageHeadings.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        if let pageContentViewController =
            storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as?
            PageContentViewController {
            print("pageContentViewController.index == \(pageContentViewController.index)")
            return pageContentViewController.index
        }
        return 0
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        if index == NSNotFound || index < 0 || index >= self.pageHeadings.count {
            return nil
        }
        
        if let pageContentViewontroller = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController {
            pageContentViewontroller.imageFile = pageImages[index]
            pageContentViewontroller.heading = pageHeadings[index]
            pageContentViewontroller.subHeading = pageSubHeadings[index]
            pageContentViewontroller.index = index
            return pageContentViewontroller
        }
        return nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
