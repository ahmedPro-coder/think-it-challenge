//
//  NiblessViewController.swift
//  SmartyHomeUIKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import UIKit

open class NiblessViewController: UIViewController {

  // MARK: - Methods
  public init() {
    super.init(nibName: nil, bundle: nil)
    if #available(iOS 13.0, *) {
        self.isModalInPresentation = true
    }
    self.modalPresentationStyle = .fullScreen
  }

  @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
  )
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
  )
  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
  }
}

