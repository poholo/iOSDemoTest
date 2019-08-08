//
//  ArtLikeAnimationView.swift
//  TomatoArt
//
//  Created by majiancheng on 2019/7/29.
//  Copyright © 2019 GymChina Inc. All rights reserved.
//

import Foundation
import CoreGraphics

@objc class ArtLikeAnimationView: UIImageView, CAAnimationDelegate {
    var angle: CGFloat!
    
    init(frame: CGRect, angle: CGFloat) {
        super.init(frame: frame)
        self.image = UIImage(named: "art_love")
        self.contentMode = .scaleAspectFit
        self.angle = angle
        let transform = CGAffineTransform.identity
        transform.rotated(by: -angle)
        self.transform = transform
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public class func showLikeAniamtion(_ superView: UIView) {
        let random = Double(arc4random() % 360) - 45.0;
        let angle = random / 360 * .pi
        let view = ArtLikeAnimationView(frame: CGRect(x: superView.frame.width / 2.0 - 40, y: superView.frame.height / 2.0 - 40, width: 80, height: 80), angle: CGFloat(angle))
        
        superView.addSubview(view)
        view.likeAnimation()
    }
    func likeAnimation() {
        let group = CAAnimationGroup()
        group.duration = 1.3
        group.beginTime = CACurrentMediaTime()
        group.autoreverses = false
        group.isRemovedOnCompletion = false
        
        let a1 = { () -> CABasicAnimation in
            let a = CABasicAnimation(keyPath: "transform.scale")
            a.fromValue = 1.0
            a.toValue = 0.6
            a.duration = 0.15
            a.beginTime = 0
            return a
        }()
        
        let a2 = { () -> CABasicAnimation in
            let a = CABasicAnimation(keyPath: "transform.scale")
            a.fromValue = 0.6
            a.toValue = 1.0
            a.duration = 0.15
            a.beginTime = a1.duration
            return a
        }()
        
        let a3 = { () -> CABasicAnimation in
            let a = CABasicAnimation(keyPath: "transform.scale")
            a.fromValue = 1.0
            a.toValue = 3.0
            a.beginTime = a2.duration + a2.beginTime + 0.5
            a.duration = 0.5
            return a
        }()
        
        let a4 = { () -> CABasicAnimation in
            let a = CABasicAnimation(keyPath: "opacity")
            a.fromValue = 1.0
            a.toValue = 0.0
            a.beginTime = a3.beginTime
            a.duration = a3.duration
            return a
        }()
        
        let a5 = { () -> CABasicAnimation in
            let a = CABasicAnimation(keyPath: "opacity")
            a.fromValue = 0.0
            a.toValue = 0.0
            a.beginTime = CACurrentMediaTime() + 1.3
            a.duration = 0.3
            return a
        }()
        
        
        group.animations = [a1, a2, a3, a4]
        group.delegate = self
        self.layer.add(group, forKey: "LikeAnimation")
        self.layer.add(a5, forKey: "removeAniamtion")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.removeFromSuperview()
    }
    
}
