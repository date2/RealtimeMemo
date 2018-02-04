//
//  MemoEditViewController.swift
//  RealtimeMemo
//
//  Created by date on 2018/02/04.
//  Copyright © 2018年 batumaru. All rights reserved.
//

import UIKit

final class MemoEditViewController: UITableViewController {

    @IBOutlet weak var descriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard !descriptionView.text.isEmpty else { return }
        
        MemoRepository.save(description: descriptionView.text) { [weak self] error in
            if let error = error {
                let controller = UIAlertController(
                    title: error.localizedDescription, message: nil, preferredStyle: .alert
                )
                self?.present(controller, animated: true)
            } else {
                self?.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
