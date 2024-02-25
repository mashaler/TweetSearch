//
//  UIViewController+Ext.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/11/02.
//

import UIKit

extension UIViewController {
    var activityIndicatorTag: Int { return 999999 }
    
    func startActivityIndicator(
        style: UIActivityIndicatorView.Style = .medium,
        location: CGPoint? = nil) {
        
        let loc = location ?? self.view.center
        
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: style)
            activityIndicator.tag = self.activityIndicatorTag
            activityIndicator.center = loc
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopActivityIndicator() {
        
        DispatchQueue.main.async {
            if let activityIndicator = self.view.subviews.filter(
                { $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func showFailureAlert(title: String, message: String, retryAction: @escaping (() -> (Void)))  {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let operationAction = UIAlertAction(title: localizedString(forKey: "tryAgin"), style: .default, handler: { (_) in
            retryAction()
        })
        let cancelAction = UIAlertAction(title: localizedString(forKey: "cancel"), style: .cancel, handler: nil)
        alertViewController.addAction(operationAction)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
}


