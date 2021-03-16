//
//  NiblessView.swift
//  SmartyHomeUIKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import UIKit

open class NiblessView: UIView {
    public var keyboardGesture: UIGestureRecognizer?

  // MARK: - Methods
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }

  @available(*, unavailable,
    message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
  )
  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
  }
}


// MARK: Keyboard Manager
public extension NiblessView {
    
    private struct Holder {
        static var _scrollView: UIScrollView?
    }
    
    private var scrollableContainer: UIScrollView? {
        get { return Holder._scrollView }
        set(newValue) { Holder._scrollView = newValue}
    }
    
    func removeKeyboardNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    func registerForKeyboardNotifications(scrollView: UIScrollView) {
        self.scrollableContainer = scrollView
        self.removeKeyboardNotificationObserver()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc
    func keyboardWasShown(_ aNotification: Notification?) {
        scrollableContainer?.keyboardWasShown(aNotification)
        addKeyboardGesture()
    }
    @objc
    func keyboardWillBeHidden(_ aNotification: Notification?) {
        scrollableContainer?.keyboardWillBeHidden(aNotification)
        removeKeyboardGesture()
    }
    
    func addKeyboardGesture() {
        if (self.keyboardGesture == nil) {
            keyboardGesture = UITapGestureRecognizer(target: self , action: #selector(hideKeyboard))
            self.addGestureRecognizer(keyboardGesture!)
        }
    }
    
    func removeKeyboardGesture() {
        if (self.keyboardGesture != nil) {
            self.removeGestureRecognizer(keyboardGesture!)
            keyboardGesture = nil
        }
    }
    
    @objc
    private func hideKeyboard() {
        self.endEditing(true)
    }
    
}

public extension UIScrollView {
    
    func keyboardWasShown(_ aNotification: Notification?) {
        let info = aNotification?.userInfo
        let keyboardSize: CGSize? = (info?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (keyboardSize?.height)!, right: 0.0)
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
        self.scrollToBottom(animated: true, offSet: (keyboardSize?.height)!)
    }
    
    func keyboardWillBeHidden(_ aNotification: Notification?) {
        let contentInsets: UIEdgeInsets = .zero
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }

    func scrollToBottom(animated: Bool, offSet: CGFloat) {
     let bottomOffset = CGPoint(x: 0, y: offSet)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}
