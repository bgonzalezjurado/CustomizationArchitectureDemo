//
//  FirstViewController.swift
//  CustomizationArchitectureDemo
//
//  Created by Borja González Jurado on 25/7/16.
//  Copyright © 2016 Borja González Jurado. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class FirstViewController: UIViewController {
    
    let className = String(describing: FirstViewController.self)
    let screenScale = UIScreen.main.scale
    
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var clubAnthemButton: UIButton!
    @IBOutlet weak var clubTopGoalsButton: UIButton!
    @IBOutlet weak var clubFirstKitButton: UIButton!
    @IBOutlet weak var clubBadgeImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        customizeTabBar()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        customizeColors()
        customizeFonts()
        customizeImages()
        customizeTexts()
        customizeViews()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func customizeTabBar() {
        
        var title = String()
        var image = UIImage()
        
        do {
            title = try Customization.getTextWithId("Text5", viewControllerName: className)
        } catch {
            Customization.handleError(.getTextWithIdError)
        }
        
        do {
            image = try Customization.getImageForViewWithName("Image1", screenScale: screenScale, viewControllerName: className)
        } catch {
            Customization.handleError(.getImageForViewWithNameError)
        }
        
        tabBarItem = UITabBarItem(title: title, image: image.withRenderingMode(.alwaysOriginal), tag: 0)
    }
    
    fileprivate func customizeColors() {
        
        do {
            let textColor = try Customization.getColorWithName("TextColor", viewControllerName: className)
            clubNameLabel.textColor = textColor
            clubAnthemButton.setTitleColor(textColor, for: .normal)
            clubFirstKitButton.setTitleColor(textColor, for: .normal)
            clubTopGoalsButton.setTitleColor(textColor, for: .normal)
            
            let backgroundColor = try Customization.getColorWithName("BackgroundColor", viewControllerName: className)
            backgroundView.backgroundColor = backgroundColor
        } catch {
            Customization.handleError(.getColorWithNameError)
        }
    }
    
    fileprivate func customizeFonts() {
        
        do {
            let titleFont = try Customization.getFontWithName("TitleFontName", fontSize: "TitleFontSize", viewControllerName: className)
            clubNameLabel.font = titleFont
            
            let textFont = try Customization.getFontWithName("TextFontName", fontSize: "TextFontSize", viewControllerName: className)
            clubAnthemButton.titleLabel?.font = textFont
            clubFirstKitButton.titleLabel?.font = textFont
            clubTopGoalsButton.titleLabel?.font = textFont
        } catch {
            Customization.handleError(.getFontWithNameError)
        }
    }
    
    fileprivate func customizeImages() {
        
        do {
            clubBadgeImageView.image = try Customization.getImageForViewWithName("Image3", screenScale: screenScale, viewControllerName: className)
        } catch {
            Customization.handleError(.getImageForViewWithNameError)
        }
    }
    
    fileprivate func customizeTexts() {
        
        do {
            clubNameLabel.text = try Customization.getTextWithId("Text1", viewControllerName: className)
            clubAnthemButton.setTitle(try Customization.getTextWithId("Text2", viewControllerName: className), for: .normal)
            clubFirstKitButton.setTitle(try Customization.getTextWithId("Text3", viewControllerName: className), for: .normal)
            clubTopGoalsButton.setTitle(try Customization.getTextWithId("Text4", viewControllerName: className) ,for: .normal)
        } catch {
            Customization.handleError(.getTextWithIdError)
        }
    }
    
    fileprivate func customizeViews() {
        
        Customization.customizeView(view: clubNameLabel, viewId: "ClubNameLabel", autoresizingMask: false)
        Customization.customizeView(view: clubBadgeImageView, viewId: "ClubBadgeImageView", autoresizingMask: false)
    }
    
    @IBAction func showFirstTshirt(_ sender: Any) {
        
        do {
            let tShirtImage = try Customization.getImageForViewWithName("Image4", screenScale: screenScale, viewControllerName: className)
        
            let tShirtView = UIImageView(image: tShirtImage)
            tShirtView.frame = view.bounds
            tShirtView.backgroundColor = UIColor.white
            tShirtView.contentMode = UIViewContentMode.center
        
            let tShirtVC: UIViewController = UIViewController()
            tShirtVC.view.frame = view.bounds
            tShirtVC.view.addSubview(tShirtView)
        
            let navigationController = UINavigationController(rootViewController: tShirtVC)
            let btnDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissNavigation))
            navigationController.topViewController?.navigationItem.leftBarButtonItem = btnDone
            present(navigationController, animated:true, completion: nil)
        } catch {
            Customization.handleError(.getImageForViewWithNameError)
        }
    }
    
    @objc func dismissNavigation() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playClubAnthem(_ sender: UIButton) {
        
        do {
            let anthemUrl = try Customization.getAudioWithId("Anthem", viewControllerName: className)
            showMultimediaViewController(resourceUrl: anthemUrl)
        } catch {
            Customization.handleError(.getAudioWithIdError)
        }
    }
    
    @IBAction func playTopGoals(_ sender: Any) {
        
        do {
            let movieUrl = try Customization.getVideoWithId("TopGoals", viewControllerName: className)
            showMultimediaViewController(resourceUrl: movieUrl)
        } catch {
            Customization.handleError(.getVideoWithIdError)
        }
    }
    
    fileprivate func showMultimediaViewController(resourceUrl: URL) {
        
        let movieVC: AVPlayerViewController = AVPlayerViewController()
        movieVC.view.frame = view.bounds
        
        let player: AVPlayer = AVPlayer(url: resourceUrl)
        movieVC.player = player
        
        present(movieVC, animated: true, completion:nil)
        movieVC.view.frame = view.frame
        
        player.play()
    }
}
