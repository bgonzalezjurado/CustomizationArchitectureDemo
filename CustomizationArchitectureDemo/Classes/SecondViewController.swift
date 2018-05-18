//
//  SecondViewController.swift
//  CustomizationArchitectureDemo
//
//  Created by Borja González Jurado on 25/7/16.
//  Copyright © 2016 Borja González Jurado. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let className = String(describing: FirstViewController.self)
    let screenScale = UIScreen.main.scale
    
    @IBOutlet weak var secondTabBarItem: UITabBarItem!
    @IBOutlet weak var trophiesTableView: UITableView!
    
    var tableData: [[String : Any]] = [[String : Any]]()
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        customizeTabBar()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        trophiesTableView.delegate = self
        trophiesTableView.dataSource = self
        
        customizeColors()
        parsingJSON()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = trophiesTableView.dequeueReusableCell(withIdentifier: "TrophieCell", for: indexPath) as! TrophieCell
        
        do {
            let entry = tableData[indexPath.row]
            guard let name = entry["name"] as? String, let number = entry["number"] as? String else {
                throw Customization.ResourcesManagerError.parsingJSONError
            }
            
            cell.trophyNameLabel?.text = name
            cell.numberOfTrophiesLabel?.text = number
        } catch {
            Customization.handleError(.parsingJSONError)
        }
        
        return cell
    }
    
    fileprivate func customizeColors() {
        
        do {
            trophiesTableView.backgroundColor = try Customization.getColorForViewWithName("BackgroundColor", viewControllerName: className)
        } catch {
            Customization.handleError(.getColorForViewWithNameError)
        }
    }
    
    fileprivate func customizeTabBar() {
        
        var title = String()
        var image = UIImage()
        
        do {
            title = try Customization.getTextWithId("Text6", viewControllerName: className)
        } catch {
            Customization.handleError(.getTextWithIdError)
        }
        
        do {
            image = try Customization.getImageForViewWithName("Image2", screenScale: screenScale, viewControllerName: className)
        } catch {
            Customization.handleError(.getImageForViewWithNameError)
        }
        
        tabBarItem = UITabBarItem(title: title, image: image.withRenderingMode(.alwaysOriginal), tag: 1)
    }
    
    fileprivate func parsingJSON() {
        
        do {
            let trophiesData = try Customization.parsingJSON()
            guard let data = trophiesData["trophies"] as? [[String : Any]] else {
                throw Customization.ResourcesManagerError.parsingJSONError
            }
            tableData = data
        } catch {
            Customization.handleError(.parsingJSONError)
        }
    }
}
