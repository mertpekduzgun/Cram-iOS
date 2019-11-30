//
//  LoadingScreen.swift
//  Cram
//
//  Created by Mert on 26.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//
import Foundation
import UIKit

class LoadingScreen {
    
    static var currentOverlay : UIView?
    static var currentOverlayTarget : UIView?
    static var currentLoadingText: String?
    
    static func show(_ loadingText: String) {
           guard let currentMainWindow = UIApplication.shared.keyWindow else {
               print("No main window.")
               return
           }
           show(currentMainWindow, loadingText: loadingText)
       }
    
    static func show(_ overlayTarget : UIView, loadingText: String?) {
        hide()
        
        let overlay = LoadingView()
        overlay.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        let templateImage = overlay.loadingImage.image?.withRenderingMode(.alwaysTemplate)
        overlay.loadingImage.image = templateImage
        
//
//        let templateLogo = overlay.logoImage.image?.withRenderingMode(.alwaysTemplate)
//        overlay.logoImage.image = templateLogo
//        overlay.logoImage.tintColor = UIColor.blues

        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.fade
        transition.subtype = .fromTop
        transition.fillMode = .removed
        
        overlayTarget.layer.add(transition, forKey: nil)
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        overlay.loadingImage.rotate()
        
        overlay.leftAnchor.constraint(equalTo: overlayTarget.leftAnchor, constant: 0.0).isActive = true
        overlay.widthAnchor.constraint(equalTo: overlayTarget.widthAnchor).isActive = true
        overlay.heightAnchor.constraint(equalTo: overlayTarget.heightAnchor).isActive = true
        
        UIView.beginAnimations(nil, context: nil)
        UIView.commitAnimations()
        
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        overlay.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true
        
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.darkGray
            label.font = .montserratRegular(ofsize: 17)
            overlay.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 150).isActive = true
            label.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        }

        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
        currentLoadingText = loadingText

    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
            currentOverlayTarget = nil
        }
    }
    
}

extension UIImageView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

