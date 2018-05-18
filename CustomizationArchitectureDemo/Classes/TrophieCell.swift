//
//  TrophieCell.swift
//  CustomizationArchitectureDemo
//
//  Created by Borja González Jurado on 25/01/2017.
//  Copyright © 2017 Borja González Jurado. All rights reserved.
//

import UIKit

class TrophieCell: UITableViewCell {
    
    let className = String(describing: FirstViewController.self)
    
    @IBOutlet weak var trophyNameLabel: UILabel!
    @IBOutlet weak var numberOfTrophiesLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        customizeColors()
        customizeFonts()
        customizeViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func customizeColors() {
        
        do {
            let textColor = try Customization.getColorForViewWithName("TextColorCell", viewControllerName: className)
            trophyNameLabel.textColor = textColor
            numberOfTrophiesLabel.textColor = textColor
        
            backgroundColor = try Customization.getColorForViewWithName("BackgroundColorCell", viewControllerName: className)
        } catch {
            Customization.handleError(.getColorForViewWithNameError)
        }
    }
    
    fileprivate func customizeFonts() {
        
        do {
            numberOfTrophiesLabel?.font = try Customization.getFontWithName("CellField1FontName", fontSize: "CellField1FontSize", viewControllerName: className)
            trophyNameLabel?.font = try Customization.getFontWithName("CellField2FontName", fontSize: "CellField2FontSize", viewControllerName: className)
        } catch {
            Customization.handleError(.getFontWithNameError)
        }
    }
    
    fileprivate func customizeViews() {
        
        Customization.customizeView(view: trophyNameLabel, viewId: "TrophyNameLabel", autoresizingMask: true)
        Customization.customizeView(view: numberOfTrophiesLabel, viewId: "NumberOfTrophiesLabel", autoresizingMask: true)
    }
}
