//
//  MemoListViewController.swift
//  RealtimeMemo
//
//  Created by date on 2018/02/03.
//  Copyright © 2018年 batumaru. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

final class MemoListViewController: UITableViewController {
    
    var memos = [Memo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _ = Auth.auth().currentUser {
            MemoRepository.gets(completion: { [unowned self] (memos, _) in
                self.memos = memos
                self.tableView.reloadData()
            })
        } else {
            presentLoginViewController()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = memos[indexPath.row].description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    @IBAction func addMemoAction(_ sender: Any) {
        presentMemoEditViewController()
    }
    
    @IBAction func signoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            presentLoginViewController()
        } catch {
            print("Sign Out error")
        }
    }

    private func presentLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
    
    private func presentMemoEditViewController() {
        let storyboard = UIStoryboard(name: "MemoEdit", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! MemoEditViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }

}
