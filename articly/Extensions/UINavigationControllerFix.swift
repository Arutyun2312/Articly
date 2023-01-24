//
//  UINavigationControllerFix.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

import Foundation
import UIKit

#if !TESTING
extension UINavigationController: UIGestureRecognizerDelegate { // force to have back gesture, even if nav bar is hidden
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool { true }
}
#endif
