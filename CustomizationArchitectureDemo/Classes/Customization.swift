//
//  Customization.swift
//  CustomizationArchitectureDemo
//
//  Created by Borja González Jurado on 5/11/16.
//  Copyright © 2016 Borja González Jurado. All rights reserved.
//

import Foundation
import UIKit

#if REALMADRIDCF
    import RealMadridCFResourcesPod
#elseif FCBARCELONA
    import FCBarcelonaResourcesPod
#endif


class Customization: ResourcesManager {
    
    static func customizeView(view: UIView, viewId: String, autoresizingMask:Bool) {
        
        let className = String(describing: FirstViewController.self)
        let orientation = UIApplication.shared.statusBarOrientation
        
        do {
            let XYcoordinates = try Customization.getViewCoordinatesWithId(viewId, orientation: orientation, viewControllerName: className)
        
            var frame = view.frame
            frame.origin = CGPoint(x: XYcoordinates[0], y: XYcoordinates[1])
            view.frame = frame
        
            if autoresizingMask {
                do {
                    view.autoresizingMask = try Customization.getViewAutoresizingWithId(viewId, orientation: orientation, viewControllerName: className)
                } catch {
                    Customization.handleError(.getViewAutoresizingWithIdError)
                }
            }
        } catch {
            Customization.handleError(.getViewCoordinatesWithIdError)
        }
    }
}
