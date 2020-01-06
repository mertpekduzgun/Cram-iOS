//
//  Helper.swift
//  Cram
//
//  Created by Mert on 22.12.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SkeletonView
import NotificationBannerSwift

class Helper {
    static func setImageWithLoading(url: String?,_ imageView: UIImageView){
        showLoading(imageView)
        if let url = URL(string: url ?? "") {
            imageView.kf.setImage(with: url,completionHandler: { result in
                switch result {
                case .success:
                    hideLoading(imageView)

                case .failure:
                    break
                }
            })
        }
    }
    
    static func showAlert(title:String,message: String,style:BannerStyle = .danger,position: BannerPosition = .top){
        let banner = NotificationBanner(title: NSLocalizedString(title, comment: ""), subtitle: message, style: style)
        if NotificationBannerQueue.default.numberOfBanners == 0 {
            banner.show(bannerPosition: position)
        }
    }
    
    static func showLoading(_ tableView: UITableView){
        tableView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        tableView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .none)
    }
    
    static func showLoading(_ view: UIView){
        view.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .none)
    }
    
    static func showLoading(_ control: UIControl){
        control.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        control.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .none)
    }
    
    static func showLoading(_ imageView: UIImageView){
        imageView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        imageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .none)
    }
    
    static func hideLoading(_ tableView: UITableView){
        UIView.animate(withDuration: 0.1,delay: 0.0 ,options: .curveEaseIn, animations: {
            tableView.alpha = 1.0
        })
        tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
    }
    
    static func hideLoading(_ view: UIView){
        UIView.animate(withDuration: 0.1,delay: 0.0 ,options: .curveEaseIn, animations: {
            view.alpha = 1.0
        })
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
    }
    
    static func hideLoading(_ control: UIControl){
        control.alpha = 0
        UIView.animate(withDuration: 1.0) {
            control.alpha = 1.0
        }
        control.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
    }
    
    static func hideLoading(_ imageView: UIImageView){
        imageView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.1))
    }
    
}
