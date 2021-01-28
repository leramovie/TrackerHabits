//
//  Helper.swift
//  BenefitTracker
//
//  Created by Valery Shel on 15.11.2020.
//

import UIKit

extension UIView {
    func addSubviewWithAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
}
