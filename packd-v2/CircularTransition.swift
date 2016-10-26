//
//  CircularTransition.swift
//  PACKD
//
//  Created by Cameron Porter on 9/27/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    
    var circle = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    
    var duration = 0.3
    
    enum CircularTransitionMode:Int {
        case present
        case dismiss
        case pop
    }
    
    var transitionMode:CircularTransitionMode = .present
}

extension CircularTransition:UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        switch transitionMode {
        case .present:
            if let presentedView = transitionContext.view(forKey: .to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor.withAlphaComponent(0.9)
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration,
                               animations: {
                                self.circle.transform = CGAffineTransform.identity
                                presentedView.transform = CGAffineTransform.identity
                                presentedView.alpha = 1
                                presentedView.center = viewCenter
                                
                    },
                               completion: { (success) in
                                transitionContext.completeTransition(success)
                })
            }
        case .dismiss:
            let transitionModeKey = UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration,
                               animations: { 
                                self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                                returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                                returningView.center = self.startingPoint
                                returningView.alpha = 0
                                
                    },
                               completion: { (success) in
                                returningView.center = viewCenter
                                returningView.removeFromSuperview()
                                self.circle.removeFromSuperview()
                                transitionContext.completeTransition(success)
                })
            }
            
        case .pop:
            let transitionModeKey = UITransitionContextViewKey.to
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration,
                               animations: {
                                self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                                returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                                returningView.center = self.startingPoint
                                returningView.alpha = 0
                                
                                containerView.insertSubview(returningView, belowSubview: returningView)
                                containerView.insertSubview(self.circle, belowSubview: returningView)
                                
                    },
                               completion: { (success) in
                                returningView.center = viewCenter
                                returningView.removeFromSuperview()
                                self.circle.removeFromSuperview()
                                transitionContext.completeTransition(success)
                })
            }
            
        }
    }
    
    private func frameForCircle(withViewCenter viewCenter:CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startingPoint.x, viewSize.width - startingPoint.x)
        let yLength = fmax(startingPoint.y, viewSize.height - startingPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: .zero, size: size)
    }
}









