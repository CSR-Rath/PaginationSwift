//
//  Loading.swift
//  EnvironmentDemo
//
//  Created by Rath! on 7/6/24.
//

import Foundation
import UIKit


public class Loading {
    
    public static let shared = Loading()
    private let blurImg = UIImageView()
    private var indicator = UIActivityIndicatorView()
    private let bgView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor =  . clear
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.3
        indicator.style = .medium
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color =  .white //.chatMessageDarkMode
        
        bgView.layer.cornerRadius = 10
        bgView.backgroundColor = .blue.withAlphaComponent(0.8)
    }
    
   public func showLoading(){
        
        DispatchQueue.main.async( execute: { [self] in
            let windows = UIApplication.shared.windows
            let keyWindow = windows.first(where: { $0.isKeyWindow })
            
            
            keyWindow?.addSubview(blurImg)
            keyWindow?.addSubview(bgView)
            keyWindow?.addSubview(indicator)
            
            
            // Center horizontally
            bgView.center.x = keyWindow?.bounds.midX ?? 0
            
            // Center vertically
            bgView.center.y = keyWindow?.bounds.midY ?? 0
        })
    }
    
    public func hideLoading(){
        
        DispatchQueue.main.async( execute: { [self] in
            blurImg.removeFromSuperview()
            bgView.removeFromSuperview()
            indicator.removeFromSuperview()
        })
    }
}
