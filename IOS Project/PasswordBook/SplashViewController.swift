//
//  SplashViewController.swift
//  PasswordBook
//
//  Created by LiangMinglong on 19/08/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import Commons

public class SplashViewController: UIViewController {
    public var pulsing: Bool = false
    
    let animatedULogoView: AnimatedULogoView = AnimatedULogoView(frame: CGRect(x: 0.0, y: 0.0, width: 90.0, height: 90.0))
    var tileGridView: TileGridView!
    
    public init(tileViewFileName: String) {
        
        super.init(nibName: nil, bundle: nil)
        tileGridView = TileGridView(TileFileName: tileViewFileName)
        view.addSubview(tileGridView)
        tileGridView.frame = view.bounds
        
        view.addSubview(animatedULogoView)
        animatedULogoView.layer.position = view.layer.position
        
        tileGridView.startAnimating()
        animatedULogoView.startAnimating()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
